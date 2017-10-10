Received: from eggs.gnu.org ([2001:4830:134:3::10]:55872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1x3I-0001ps-ET
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1x3D-0006eW-Hl
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:06:40 -0400
Date: Tue, 10 Oct 2017 13:00:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171010160015.GF3246@localhost.localdomain>
References: <20171010133241.11330-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010133241.11330-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pc: remove useless hot_add_cpu
 initialisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, "Michael S . Tsirkin" <mst@redhat.com>, Anthony Perard <anthony.perard@citrix.com>

On Tue, Oct 10, 2017 at 03:32:41PM +0200, Laurent Vivier wrote:
> Since 4458fb3a79 (pc: Eliminate pc_default_machine_options()),
> hot_add_cpu is set in pc_machine_class_init(), so we don't
> need to set it in pc_q35_machine_options(), pc_i440fx_machine_options()
> and xenfv_machine_options(), except to clear it in
> pc_i440fx_1_4_machine_opt().
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
