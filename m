Received: from eggs.gnu.org ([2001:4830:134:3::10]:60014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBflv-0005sH-RJ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBflu-0001C3-P2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:13:11 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:44534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBflu-0001Bv-JP
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:13:10 -0400
Received: by mail-oi0-x235.google.com with SMTP id e80-v6so16434336oig.11
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 05:13:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180426140807.4a4a577b.olaf@aepfle.de>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
	<CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
	<c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
	<20180426140807.4a4a577b.olaf@aepfle.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 13:12:49 +0100
Message-ID: <CAFEAcA_LnnBXf9f8UZ=6upipb2QN5GQd6XTwxHbp+yCmpPGnOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 26 April 2018 at 13:08, Olaf Hering <olaf@aepfle.de> wrote:
> Am Thu, 26 Apr 2018 13:52:04 +0200
> schrieb Paolo Bonzini <pbonzini@redhat.com>:
>
>> min-glib Dockerfile is using glib 2.22
>
> Why did it not prevent the bad commit from entering 2.12?

Most immediately, because I don't use that as part of
my per-merge testing.

thanks
-- PMM
