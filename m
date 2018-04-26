Received: from eggs.gnu.org ([2001:4830:134:3::10]:38805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fBgEA-00043p-LY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fBgE5-0004lx-5O
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:42:22 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:41410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fBgE4-0004lM-US
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:42:17 -0400
Received: by mail-wr0-f170.google.com with SMTP id g21-v6so29159099wrb.8
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 05:42:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
	<CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
	<c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
	<20180426140807.4a4a577b.olaf@aepfle.de>
	<20180426121002.GG26812@redhat.com>
	<20180426141140.7d7b39d0.olaf@aepfle.de>
	<b976e072-78c5-e12a-ba72-2075b8b635e3@redhat.com>
Message-ID: <79669d21-8f20-dff2-83c3-c3fd95dfe179@redhat.com>
Date: Thu, 26 Apr 2018 14:42:12 +0200
MIME-Version: 1.0
In-Reply-To: <b976e072-78c5-e12a-ba72-2075b8b635e3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 26/04/2018 14:39, Paolo Bonzini wrote:
> On 26/04/2018 14:11, Olaf Hering wrote:
>> Am Thu, 26 Apr 2018 13:10:02 +0100
>> schrieb Daniel P. Berrangé <berrange@redhat.com>:
>>
>>> Presumably the min-glib docker job didn't enable the vfio feature, which
>>> is what contained the bad code.
>>
>> It is Linux=y, every following commit would have failed too.
>> I suggest to revisit that testcase.
> 
> That's because Red Hat backported g_realloc_n into RHEL6 :) probably
> because it's used for security reasons and they expected users to appear
> in the next 10-ish years.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=573966

Almost.  It's because the g_*alloc_n was introduced in order to fix
overflows in g_*new.  When Red Hat fixed the overflows, that implicitly
added those functions.

Paolo
