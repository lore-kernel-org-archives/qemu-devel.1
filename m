Received: from eggs.gnu.org ([2001:4830:134:3::10]:41904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f0pF4-0007ux-RT
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f0pF0-0001Zi-QE
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:06:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1f0pF0-0001ZS-Kq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:06:22 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180327113452.19613-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Tue, 27 Mar 2018 12:34:49 +0100")
References: <20180327113452.19613-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 27 Mar 2018 16:06:17 +0200
Message-ID: <87a7utlijq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/3] e1000 migration changes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, eswierk@skyportsystems.com, jasowang@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Hi Ed, Jason,
>   This set of patches change the e1000 migration code to make
> it easier to keep with compatibility with older versions in backwards
> migration;  but I do need some advice whether I need to do more as well.
>
> I think the first and second patch are fairly uncontrovercial and I
> would like them for 2.12, since it'll make any future changes easier.
> The third one changes the default behaviour, so again I'd prefer it but
> lets see what you think.
>
> My question however, without knowing the internals of the e1000, is
> whether when ommitting the subsection, should the code in 2.12 be
> changing the data it sends back in the main section of data?
>
> Dave

Reviewed-by: Juan Quintela <quintela@redhat.com>

For the whole series.

I would have merged patch 1 & 2, but as you are the one coding them.

Later, Juan.
