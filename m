Received: from eggs.gnu.org ([2001:4830:134:3::10]:52221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fJkKI-0002db-H9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fJkKH-0004Vm-PB
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:42:02 -0400
Date: Fri, 18 May 2018 19:41:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180518184151.GA2479@work-vm>
References: <20180518132114.4070-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180518132114.4070-1-kwolf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/40] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, marcandre.lureau@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com

* Kevin Wolf (kwolf@redhat.com) wrote:
> Before we can make x-blockdev-create a background job, we need to
> generalise the job infrastructure so that it can be used without any
> associated block node.

Is there any relationship between what this does, and what
Marc-Andr=E9's 'monitor: add asynchronous command type' tries to do?
(See 20180326150916.9602-1-marcandre.lureau@redhat.com 26th March)

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
