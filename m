Received: from eggs.gnu.org ([2001:4830:134:3::10]:52944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAZlS-00064E-JJ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 07:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAZlL-0005LS-SL
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 07:36:09 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:41539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAZlL-0005Ie-M5
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 07:36:03 -0400
Received: from player737.ha.ovh.net (unknown [10.109.120.28])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 1EE0E1559A2
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 13:36:02 +0200 (CEST)
References: <20180423064020.25434-1-clg@kaod.org>
	<CAFEAcA-LtNpGTV08jvK4i5C5i64WjM5gMB4zGr8P4fkVSkNH7g@mail.gmail.com>
	<53691cbf-08bf-e3f7-22d3-601a279aa08a@kaod.org>
	<CAFEAcA9XBHE5YxN27M1ugprmSf=o5iiNakO2omrY+HBgCszV5Q@mail.gmail.com>
	<a5ca89ac-7c8f-c565-30d0-357bacb1f61e@kaod.org>
	<20180423104622.GG2518@work-vm>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0fe02e1a-576b-cd6e-a79c-ede821cab983@kaod.org>
Date: Mon, 23 Apr 2018 13:35:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180423104622.GG2518@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

>>> I think it's nice to at least do the "bump version" thing, so you
>>> get a (hopefully comprehensible) error rather than just wrong
>>> data if you do try a cross version migration, 
>>
>> On that topic, the error message was :
>>
>> 	Missing section footer for aspeed.timerctrl
>>
>> which is not very comprehensible for a version mismatch issue.
> 
> Was that before your patch?

yes.

> The VMSTATE fields in the structure have no metadata stored
> for them to be parsed with; if you send a different number
> of array entries to the number the destination receives you end
> up with a corrupt stream. Section footers are just a canary
> that tells you something went wrong in that devices data.
> It has no more information to give you a more detailed error.

OK. Thanks for the explanation.

C.
