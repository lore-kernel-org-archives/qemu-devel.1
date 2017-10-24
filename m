Received: from eggs.gnu.org ([2001:4830:134:3::10]:48481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=463712e83=anthony.perard@citrix.com>)
	id 1e70Eu-0002TJ-F7
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 10:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=463712e83=anthony.perard@citrix.com>)
	id 1e70Em-0004uy-D4
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 10:31:32 -0400
Received: from smtp.citrix.com ([66.165.176.89]:52649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=463712e83=anthony.perard@citrix.com>)
	id 1e70Em-0004uP-66
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 10:31:24 -0400
Date: Tue, 24 Oct 2017 15:26:55 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171024142655.GF1885@perard.uk.xensource.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<55afe994ca32715382326d5d250231bdaa836f08.1508390588.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55afe994ca32715382326d5d250231bdaa836f08.1508390588.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v3 41/46] hw/xen*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Oct 19, 2017 at 09:18:14AM -0700, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> xen_pt_log() was left with an fprintf(stderr,
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
