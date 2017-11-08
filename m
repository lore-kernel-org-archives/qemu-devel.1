Received: from eggs.gnu.org ([2001:4830:134:3::10]:49358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1eCJrT-0003LY-Jq
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1eCJrQ-00029F-Eq
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:29:19 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:56156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slopezpa@redhat.com>) id 1eCJrQ-00028X-Al
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:29:16 -0500
Received: by mail-vk0-f46.google.com with SMTP id b7so1041679vkh.12
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 22:29:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108012907.GA2834@lemon>
References: <20171107225426.3822-1-slp@redhat.com>
	<20171108012907.GA2834@lemon>
From: Sergio Lopez Pascual <slp@redhat.com>
Date: Wed, 8 Nov 2017 07:29:14 +0100
Message-ID: <CAAiTLFVCiTQHxUATRd6shBePPNxq+fFVpBhQsuu-LF_4HvKDvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] util/async: use atomic_mb_set in
 qemu_bh_cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Hi Fam,

On Wed, Nov 8, 2017 at 2:29 AM, Fam Zheng <famz@redhat.com> wrote:
>>        I/O thread                  |          worker thread
>
> Isn't the left column "workder thread" and the right one "I/O thread"?
>

Yes, you're right. I'm going to switch them back.

Thanks,
Sergio.
