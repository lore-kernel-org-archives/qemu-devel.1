Received: from eggs.gnu.org ([2001:4830:134:3::10]:44014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYCTX-00022W-Vf
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYCTR-0004UN-IB
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:35:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYCTR-0004Tm-5h
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:35:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B16431133F9
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 15:35:12 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-6-pbonzini@redhat.com>
	<99e4c61b-38a2-37c8-091b-06a9f79955cc@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32881929-d59c-1622-271a-9804dee8660c@redhat.com>
Date: Wed, 27 Jun 2018 17:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <99e4c61b-38a2-37c8-091b-06a9f79955cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] pr-manager-helper: report event on
 connection/disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org

On 27/06/2018 12:16, Michal Privoznik wrote:
> Also, can we emit this earlier? For instance at the two places where we
> unset pr_mgr->ioc:
> 
> With your approach the event is emitted only after the 5 reconnect 
> attempts (which makes little sense IMO). With my approach the event is 
> emitted a bit sooner so that reconnect has at least chance of 
> succeeding.

Much better, yes.  I included your change.

Paolo
