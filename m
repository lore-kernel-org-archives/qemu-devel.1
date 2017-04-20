Received: from eggs.gnu.org ([2001:4830:134:3::10]:55522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d18Xj-0001EV-JL
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d18Xi-00013o-Nb
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:38:27 -0400
MIME-Version: 1.0
In-Reply-To: <20170420093325.GA4747@noname.redhat.com>
References: <1492679992-7805-1-git-send-email-lidongchen@tencent.com>
	<20170420093325.GA4747@noname.redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 20 Apr 2017 17:38:25 +0800
Message-ID: <CAOGPPbcyiFU6Z16rWRCAw4XEOHhp8WN+9KPepnjkSqu6wTR8Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: check bs_n when use old style
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, mreitz@redhat.com, qemu block <qemu-block@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Thu, Apr 20, 2017 at 5:33 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 20.04.2017 um 11:19 hat jemmy858585@gmail.com geschrieben:
>> From: Lidong Chen <lidongchen@tencent.com>
>>
>> When use old style option like -o backing_file, img_convert
>> continue run when bs_n > 1, this patch fix this bug.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>
> I think this is a duplicate of Max' "[PATCH for-2.10 3/3]
> qemu-img/convert: Move bs_n > 1 && -B check down".
ok, thanks.

>
> Also, -B is the old-style option, not -o backing_file.
>
> Kevin
