Received: from eggs.gnu.org ([2001:4830:134:3::10]:40854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eEBam-0004nW-8m
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eEBai-00066b-VZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:03:48 -0500
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:49981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eEBai-0005zG-Ov
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:03:44 -0500
Received: from player730.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id D7C67A808B
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 11:03:34 +0100 (CET)
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<CAFEAcA_vZ6KNQzsRTeFujf3W7cqXi-Y9qJS0-EtodB24jsQe+w@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b65a5baf-e2a8-ec3a-7c28-4046a2fc8dec@kaod.org>
Date: Mon, 13 Nov 2017 11:03:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_vZ6KNQzsRTeFujf3W7cqXi-Y9qJS0-EtodB24jsQe+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On 11/13/2017 10:53 AM, Peter Maydell wrote:
> On 13 November 2017 at 07:14, Thomas Huth <thuth@redhat.com> wrote:
>> By the way, before everybody now introduces "2.12" machine types ... is
>> there already a consensus that the next version will be "2.12" ?
>>
>> A couple of months ago, we discussed that we could maybe do a 3.0 after
>> 2.11, e.g. here:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html
>>
>> I'd still like to see that happen... Peter, any thoughts on this?
> 
> I don't see the point in declaring a 3.0 unless we have some
> sweeping change that merits it. I don't think we should do a
> sweeping change unless we have a well laid out and agreed on
> plan for how the transition works. So I would want to see the
> plan discussed and agreed first, and then we can say "ok, and
> we think we can do this in this timescale and so the version
> at $DATE will be 3.0". Changing the version number should be
> the last part of this process, not the first, in my view.

One of the sweeping change for 3.0 could be to stop to maintaining
migration compatibility with older versions (2.x). Even if the 
feature is really a must have in some cluster environment, the 
code (and the developer) is starting to suffer from it.


Thanks,

C.
