Received: from eggs.gnu.org ([2001:4830:134:3::10]:34217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ek22f-0001oK-13
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 01:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ek22a-0007Bt-EO
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 01:20:13 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ek22a-0007Aw-9t
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 01:20:08 -0500
Received: by mail-ua0-f175.google.com with SMTP id g5so4501936uac.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 22:20:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209060710.GB2783@xz-mi>
References: <20180208103132.28452-1-peterx@redhat.com>
	<151808912011.285.15166058884960463518@bdbb90650ae5>
	<20180209060710.GB2783@xz-mi>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 9 Feb 2018 14:19:34 +0800
Message-ID: <CAK1Eb9kmhv+CRv1oR=_Vdw_PDaQfi9MvZRkF3D19TZa=KPkzPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 00/28] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Feb 9, 2018 at 2:07 PM, Peter Xu <peterx@redhat.com> wrote:
> On Thu, Feb 08, 2018 at 03:25:21AM -0800, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series failed docker-mingw@fedora build test. Please find the testing commands and
>> their output below. If you have Docker installed, you can probably reproduce it
>> locally.
>
> For all the five patchew reports: I forgot to add based-on tag.  This
> series is based on monitor-oob series.

OK. If you reply with a correct Based-on: tag, patchew will
automatically retry to apply it. (I think it currently doesn't re-run
the tests, but we could probably add such a feature to it, as a note
to myself.)

Fam

>
> --
> Peter Xu
