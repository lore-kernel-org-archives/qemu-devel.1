Received: from eggs.gnu.org ([2001:4830:134:3::10]:45146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d3G5H-0005bj-L3
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d3G5E-0001Mk-Ci
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:05:51 -0400
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:50553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d3G5E-0001MZ-5e
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:05:48 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id CCCF46E3B9
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:05:43 +0200 (CEST)
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
	<1493103101-25165-3-git-send-email-clg@kaod.org>
	<20170426024244.GK16882@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c48d3352-582b-d2ba-d3b5-c107994d5c21@kaod.org>
Date: Wed, 26 Apr 2017 08:05:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170426024244.GK16882@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] ipmi: don't try to open a NULL filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 04/26/2017 04:42 AM, David Gibson wrote:
> On Tue, Apr 25, 2017 at 08:51:41AM +0200, C=E9dric Le Goater wrote:
>> Currenlty, the code relies on the fact that open() handles NULL
>> filenames but that can cause an error with new clang:
>>
>>   hw/core/loader.c:67:15: runtime error: null pointer passed as argume=
nt 1,
>>   which is declared to never be null
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Since my ppc-for-2.10 pull request has been held up because of this
> anyway, tather than just apply this on top, I've folded it into your
> earlier patch which caused the bug - that way we won't break bisect.

Yes that is the best option.=20

Thanks,

C.
