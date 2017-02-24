Received: from eggs.gnu.org ([2001:4830:134:3::10]:51896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1chEI6-0005gF-Ca
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1chEI3-0004bM-AS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:44:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1chEI3-0004aK-4K
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:43:59 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 422067E9D6
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:43:59 +0000 (UTC)
Date: Fri, 24 Feb 2017 12:43:55 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170224114355.lvqu4stzwfz34r4d@eukaryote>
References: <20170223144034.b2bhgsvwfyyymxwk@eukaryote>
	<87ino1gcx2.fsf@dusky.pond.sub.org>
	<20170223163315.w2nekel42grwtbkc@eukaryote>
	<36a8c750-8490-1c5d-ca12-cc2b8c594334@redhat.com>
	<20170224105312.7lephvjbipszrb3p@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170224105312.7lephvjbipszrb3p@eukaryote>
Subject: Re: [Qemu-devel] Adding an overlay with 'blockdev-add' fails with:
 "Parameter 'driver' is missing"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Fri, Feb 24, 2017 at 11:53:12AM +0100, Kashyap Chamarthy wrote:

[...]

> However, bizzarely enough, when I ran `query-block` after `blockdev-add`
> succeeded (well, at least after it returned success), I don't see the
> new node ('target.qcow2') reflected in the return output.  Me
> investigates.

Okay, Kevin educated me IRC that I should rather use
`query-named-block-nodes`.  That gives the intended output.

[...]

-- 
/kashyap
