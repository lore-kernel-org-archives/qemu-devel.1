Received: from eggs.gnu.org ([2001:4830:134:3::10]:47650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxvUq-0004OU-VF
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxvUn-0002de-7s
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:06:12 -0400
Date: Tue, 11 Apr 2017 21:05:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170411130558.GD8507@lemon>
References: <20170410075451.21329-1-famz@redhat.com>
	<24011a9e-eab2-60b4-48a2-0e5ec1f4cf12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24011a9e-eab2-60b4-48a2-0e5ec1f4cf12@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] iscsi: Fix iscsi_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>

On Mon, 04/10 17:17, Max Reitz wrote:
> >      bs_options = qdict_new();
> >      qdict_put(bs_options, "filename", qstring_from_str(filename));
> 
> Doesn't the below change make this qdict_put() superfluous?

You are right, bdrv_iscsi.bdrv_needs_filename is false.

Fam
