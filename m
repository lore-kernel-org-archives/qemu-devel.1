Received: from eggs.gnu.org ([2001:4830:134:3::10]:58384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEW2j-0005vl-Uy
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEW2f-0005MK-4j
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:54:02 -0500
References: <cover.1510612380.git.alistair.francis@xilinx.com>
	<ccfeb16d932f9570efc871c6aa1c2d1229bf31ba.1510612380.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3220ca4b-12f9-727e-da70-188dd1f9c262@redhat.com>
Date: Tue, 14 Nov 2017 08:53:52 +0100
MIME-Version: 1.0
In-Reply-To: <ccfeb16d932f9570efc871c6aa1c2d1229bf31ba.1510612380.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 15/29] hw/moxie: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair23@gmail.com, Anthony Green <green@moxielogic.com>, armbru@redhat.com

On 13.11.2017 23:35, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
