Received: from eggs.gnu.org ([2001:4830:134:3::10]:41585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmN5-0007Av-8p
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjmN1-0007NS-EJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjmN1-0007Mn-8m
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:31:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6460637E72
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 12:31:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v23CVax0020216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 3 Mar 2017 07:31:38 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488308796-28832-1-git-send-email-armbru@redhat.com>
Date: Fri, 03 Mar 2017 13:31:35 +0100
In-Reply-To: <1488308796-28832-1-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Tue, 28 Feb 2017 20:06:10 +0100")
Message-ID: <87k286zgm0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/26] QAPI patches for 2017-02-28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can break with multiple monitors race against each other:
NAK
