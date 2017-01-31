Received: from eggs.gnu.org ([2001:4830:134:3::10]:36976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYaew-0003Qi-QK
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYaew-0000dp-6e
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:47:54 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYaew-0000d6-1l
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:47:54 -0500
Received: by mail-ua0-x22d.google.com with SMTP id 96so275483821uaq.3
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 07:47:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87zii75jze.fsf@dusky.pond.sub.org>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<87zii75jze.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 15:47:32 +0000
Message-ID: <CAFEAcA9hu_zhfE6F1Sj-ZYrp40ki2yTigtonkk_PZDE7qjhO4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 31 January 2017 at 15:26, Markus Armbruster <armbru@redhat.com> wrote:
> __COUNTER__ was added to GNU cpp in 2007.  Good.  What about clang?
> "clang -dM -E -x c /dev/null" comes up empty on my machine (3.8.0).

Since __COUNTER__ is magic it doesn't appear in the -dM output.
You can test for it working with
echo 'counter is __COUNTER__ __COUNTER__' | clang -E -x c -

thanks
-- PMM
