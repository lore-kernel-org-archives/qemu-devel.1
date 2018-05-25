Received: from eggs.gnu.org ([2001:4830:134:3::10]:55847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMJmf-0005M4-70
	for qemu-devel@nongnu.org; Fri, 25 May 2018 16:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMJme-0007Wv-CB
	for qemu-devel@nongnu.org; Fri, 25 May 2018 16:57:57 -0400
Date: Fri, 25 May 2018 23:57:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525235655-mutt-send-email-mst@kernel.org>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-16-git-send-email-mst@redhat.com>
	<87vabb1thk.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vabb1thk.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v2 15/20] migration: use local path for
 local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

On Fri, May 25, 2018 at 08:27:03PM +0200, Juan Quintela wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > When pulling in headers that are in the same directory as C file (as
> > opposed to one in include/), we should use its relative path, without a
> > directory. Directory based path works more or less by accident.
> 
> I don't agree with the comment that they work by accident,

Oh I removed this from most commit messages but somehow this one managed
to sneek in.  I agree, will drop this sentence.

> it is
> "by-design".  But if you want to change the design, I agree with
> removing "$ROOT" from the default include path.
> 
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> Later, Juan.

Thanks!
