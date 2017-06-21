Received: from eggs.gnu.org ([2001:4830:134:3::10]:52492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1dNeVS-0003ba-Dt
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1dNeVN-00046l-Fa
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:13:10 -0400
Received: from smtp0.epfl.ch ([2001:620:618:1e0:1:80b2:e058:1]:45596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hossein.ajallooiean@epfl.ch>)
	id 1dNeVN-00044g-5Q
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:13:05 -0400
From: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>
Date: Wed, 21 Jun 2017 11:46:20 +0000
Message-ID: <1498045580087.46004@epfl.ch>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Looking for ideas: Single process vs multi process
 qemu instances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi All,


we are trying to do server simulation and for that purpose we need to have =
multiple Qemu instances (each can have a different spec) that are part of a=
 virtual network (ns-3 in our case).


Now for the Qemu implementation part: would it be easier/better to have all=
 the Qemu instances under a single process or multiple processes? i am assu=
ming if one single process is used, there will be a threading conflict that=
 would probably need to be looked at.


I am looking at this purely from a management/performance view.


Any ideas/suggestions?


Thanks

Hoss
