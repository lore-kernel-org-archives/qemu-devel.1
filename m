Received: from eggs.gnu.org ([2001:4830:134:3::10]:45510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQM3Y-0000aY-Qs
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 19:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQM3U-0008DB-2j
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 19:07:32 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQM3T-0008Cr-Sd
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 19:07:28 -0400
Date: Wed, 28 Jun 2017 19:07:25 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170628230725.GA9893@flamenco>
References: <149855711979.4578.11884555663631849051.stgit@frigg.lan>
	<20170627175815.GA17639@flamenco> <878tkce4sm.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878tkce4sm.fsf@frigg.lan>
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
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Jun 28, 2017 at 14:21:29 +0300, Lluís Vilanova wrote:
> Emilio G Cota writes:
> > I wanted to save you some time and sent a v9 yesterday with these
> > same changes -- although I see some changes in my v8 didn't make it
> > to your v9. For this iteration I only added more perf numbers to the
> > last patch, see here:
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05764.html
> 
> Woops, sorry about the duplicate effort.
> 
> I just dropped the rename of variable trace_ds, since I prefer names whose
> purpose can be more easily understood.

- I think trace_vcpu_dstate is way too long (IMO a short name + a comment
  in the struct is better).

- You missed a change I made to patch 3:
> [cota: use CPU_TRACE_DSTATE_MAX_EVENTS instead of trace_get_vcpu_event_count()]
  Was that intentional?

- Would be nice to include the perf numbers I got, along with yours.

		E.
