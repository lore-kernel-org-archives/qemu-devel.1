Received: from eggs.gnu.org ([2001:4830:134:3::10]:44234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XAT-000166-Uy
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XAP-0006ae-TM
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:05 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170421111220.32673-1-berrange@redhat.com> (Daniel
	P. Berrange's message of "Fri, 21 Apr 2017 12:12:20 +0100")
References: <20170421111220.32673-1-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 21 Apr 2017 13:55:58 +0200
Message-ID: <87o9vqc6up.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: setup bi-directional I/O
 channel for exec: protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-stable@nongnu.org

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> Historically the migration data channel has only needed to be
> unidirectional. Thus the 'exec:' protocol was requesting an
> I/O channel with O_RDONLY on incoming side, and O_WRONLY on
> the outgoing side.
>
> This is fine for classic migration, but if you then try to run
> TLS over it, this fails because the TLS handshake requires a
> bi-directional channel.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Actually, lots of people request that we have bi-directional
communication always that it is possible.
