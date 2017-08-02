Received: from eggs.gnu.org ([2001:4830:134:3::10]:55496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcvgN-0002nu-57
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcvgM-0002hf-Ht
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:35:35 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:33969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcvgM-0002h5-AR
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:35:34 -0400
Received: by mail-wm0-x22b.google.com with SMTP id t138so41681404wmt.1
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 08:35:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170727095557.GA2080@work-vm>
References: <1501149097-19071-1-git-send-email-thuth@redhat.com>
	<20170727095557.GA2080@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Aug 2017 16:35:12 +0100
Message-ID: <CAFEAcA91AqAMXfUcthirZkN1YN1pjeub7yVpS7apFkVeMkY_EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/hmp: Fix typo in the
 'chardev-send-break' test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Fritsch <sf@sfritsch.de>, QEMU Developers <qemu-devel@nongnu.org>

On 27 July 2017 at 10:55, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Thomas Huth (thuth@redhat.com) wrote:
>> testchardev2 is not a valid chardev id here. Use testchardev1
>> instead which has been created with chardev-add right before
>> the 'chardev-send-break' line.
>> And while we're at it, add the test-hmp.c file to the MAINTAINERS
>> file, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks, applied to master.

-- PMM
