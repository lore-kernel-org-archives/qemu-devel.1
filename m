Received: from eggs.gnu.org ([2001:4830:134:3::10]:51564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cWFjI-0007Ja-Ed
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 00:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit.shah@redhat.com>) id 1cWFjF-00015i-7y
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 00:02:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit.shah@redhat.com>)
	id 1cWFjF-00015e-2M
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 00:02:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0730DC04B94B
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 05:02:41 +0000 (UTC)
Date: Wed, 25 Jan 2017 10:32:35 +0530
From: Amit Shah <amit.shah@redhat.com>
Message-ID: <20170125050235.GD1679@amit-lp.rh>
References: <20161212125838.14425-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212125838.14425-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [for 2.9] migration/tracing: Add tracing on save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On (Mon) 12 Dec 2016 [12:58:38], Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add some tracing to vmstate_subsection_save and vmstate_save_state
> to help in debugging when you're not sure if a conditional piece
> of data is being saved.
> 
> In vmstate_subsection_save I renamed the inner vmsd to avoid the aliasing
> and be able to print both names.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Amit Shah <amit.shah@redhat.com>

		Amit
