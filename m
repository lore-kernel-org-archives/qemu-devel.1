Received: from eggs.gnu.org ([2001:4830:134:3::10]:49957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPukq-0003TT-1m
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPukl-00042o-Bt
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:58:24 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dPukk-000401-S3
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:58:19 -0400
Date: Tue, 27 Jun 2017 13:58:15 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170627175815.GA17639@flamenco>
References: <149855711979.4578.11884555663631849051.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149855711979.4578.11884555663631849051.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v9 0/7] trace: [tcg] Optimize per-vCPU
 tracing states with separate TB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jun 27, 2017 at 12:52:00 +0300, Lluís Vilanova wrote:
> Changes in v9
> =============
> 
> * Rebase on 931892e8a6.
> * Undo renaming of tb->trace_vcpu_dstate to the shorter tb->trace_ds.
> * Add measurements to commit enabling all guest events.

I wanted to save you some time and sent a v9 yesterday with these
same changes -- although I see some changes in my v8 didn't make it
to your v9. For this iteration I only added more perf numbers to the
last patch, see here:
  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05764.html

		E.
