Received: from eggs.gnu.org ([2001:4830:134:3::10]:37013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cil6C-0006pS-ED
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cil67-0004Yy-KT
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:58:04 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:19744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1cil67-0004XP-AT
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:57:59 -0500
Date: Tue, 28 Feb 2017 17:57:30 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170228165730.ovdh4k6psrd3qv33@var.youpi.perso.aquilenet.fr>
References: <20170220185020.774-1-dgilbert@redhat.com>
	<20170220185020.774-5-dgilbert@redhat.com>
	<8760k3od2r.fsf@emacs.mitica> <20170223105155.GA2383@work-vm>
	<20170223110433.GL10047@redhat.com> <20170223114045.GB2383@work-vm>
	<20170226203427.6xjmuvt6okc356e5@var.youpi.perso.aquilenet.fr>
	<20170228165445.GG2773@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170228165445.GG2773@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] slirp: VMStatify socket level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, jan.kiszka@siemens.com, maethor@subiron.org

Dr. David Alan Gilbert, on mar. 28 févr. 2017 16:54:46 +0000, wrote:
> I'm thinking one way to do it without changing the version would
> be to use the existing value for IPv4, and on reading allow any other
> value for IPv6 (or just the ones we know about); that would make
> it inwards migration compatible.

Right. I don't know if that's enough for QEMU requirements.

Samuel
