Received: from eggs.gnu.org ([2001:4830:134:3::10]:36180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cT2VW-0007S0-Do
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cT2VT-000392-AW
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:19:14 -0500
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:40869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cT2VT-00038l-48
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 03:19:11 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 507D87978C
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:19:07 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-12-git-send-email-clg@kaod.org>
	<b5660d74-0c16-871b-bec0-31a5a6e19f04@gmail.com>
	<9b1c1700-04cc-9b1e-6fdc-5ac84e5cd42e@kaod.org>
	<e6c78999-f851-eb32-6244-80e85e0b5190@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <64b13418-337d-d3a6-2c65-0add542c9ba8@kaod.org>
Date: Mon, 16 Jan 2017 09:18:57 +0100
MIME-Version: 1.0
In-Reply-To: <e6c78999-f851-eb32-6244-80e85e0b5190@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/11] aspeed/smc: handle dummy bytes
 when doing fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

> I did not notice that this function is also called in writes, isn't it?
> If yes, dummy cycles are used only during reads so probably CTRL_FREADMODE
> needs to be tested.

yes. I can take care of that in a follow up patchset for 
dummy support.
 
Dummies in user mode is a bit painful to implement, as I had 
to snoop into the command flow to catch the fast read op.
Not sure this is the right approach so I kept it for later.


Did you have time to take look at the other patches adding 
Command mode and extending the tests ? I should have addressed
your comments there.

Thanks,

C.     
