Received: from eggs.gnu.org ([2001:4830:134:3::10]:50754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFMkW-0000L7-Tg
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFMkV-0003Ae-Tm
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:10:44 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFMkV-00039U-Lh
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:10:43 -0500
Received: by mail-wm0-x232.google.com with SMTP id r68so1298901wmr.1
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 08:10:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171116175149-mutt-send-email-mst@kernel.org>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
	<CAFEAcA_f_Pxd8aX606KBamm4sKvodr1xt9o4_hbONnqx1uTBBQ@mail.gmail.com>
	<20171116173033-mutt-send-email-mst@kernel.org>
	<20171116154534.GR16461@redhat.com>
	<20171116175149-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2017 16:10:22 +0000
Message-ID: <CAFEAcA_DqWVaZ-oK8S9j9Hqu_AJ5nE2g9waf7Gd5vmeyKGZLsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] pc, pci, virtio: fixes for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 November 2017 at 15:56, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Nov 16, 2017 at 03:45:34PM +0000, Daniel P. Berrange wrote:
>> On Thu, Nov 16, 2017 at 05:38:18PM +0200, Michael S. Tsirkin wrote:
>> > I think it's     test: fix detection of errors from iasl
>> > I'll drop it for now.
>>
>> I think that patch is merely exposing a failure that has always
>> happened, but which we've never noticed before. So dropping that
>> patch just hides the error again, doesn't fix the error.

> We shouldn't fail test if system can't load expected files.
> This just will trip up people trying to build qemu.

If there are known-buggy iasl versions in the wild we could
consider a configure test and treat buggy-iasl like no-iasl.

thanks
-- PMM
