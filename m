Received: from eggs.gnu.org ([2001:4830:134:3::10]:36699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dNkKI-00048P-0X
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 14:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1dNkKD-0007oK-4N
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 14:26:02 -0400
Received: from mail5.windriver.com ([192.103.53.11]:33834 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1dNkKC-0007ng-SA
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 14:25:57 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v5LIPpdB030733
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 11:25:51 -0700
Message-ID: <594ABA2C.2060504@windriver.com>
Date: Wed, 21 Jun 2017 12:25:48 -0600
From: Chris Friesen <chris.friesen@windriver.com>
MIME-Version: 1.0
References: <20131107133921.24319.20662.malonedeb@gac.canonical.com>
	<149806671142.3407.13126852924519842175.malone@gac.canonical.com>
In-Reply-To: <149806671142.3407.13126852924519842175.malone@gac.canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1248959] Re: pdpe1gb flag is missing in guest
 running on Intel h/w
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 06/21/2017 11:38 AM, Anatol Pomozov wrote:
> I observe the same situation. My host CPU (Intel Xeon CPU E5-2690)
> supports 1gb pages but qemu keeps it disabled by default. I have to use
> either '-cpu phenom' or '-cpu host' with KVM.
>
> It makes me wondering what is the default CPU for QEMU? Is it possible
> to set qemu CPU featureset closer to what host CPU has?

As I understand it there is no well-defined default CPU for qemu that is 
guaranteed to be stable across versions.

Last I checked if you use the default CPU model then you get something that 
calls itself "qemu64", but explicitly setting the "qemu64" cpu model doesn't 
work when enabling kvm support on an Intel host CPU, because it wants the "svm" 
CPU feature.  (Does this strike anyone else as inconsistent?)

The "kvm64" CPU model works on Intel, but doesn't provide as many CPU features 
as what you get if you don't specify a model.

Chris
