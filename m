Received: from eggs.gnu.org ([2001:4830:134:3::10]:55715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBcR-0001gi-HG
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBcQ-0003q5-C0
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:21:39 -0500
Date: Tue, 6 Feb 2018 20:21:29 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180206222129.GD13301@localhost.localdomain>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
	<1516694904-64879-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516694904-64879-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 02/25] tests: add machine 'none' with
 -cpu test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>

On Tue, Jan 23, 2018 at 09:08:01AM +0100, Igor Mammedov wrote:
> Check that "$QEMU -M none -cpu FOO" starts QEMU without error
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
[...]
> +struct arch2cpu {
> +    const char *arch;
> +    const char *cpu_model;
> +};
> +
> +static struct arch2cpu cpus_map[] = {
> +    /* tested targets list */
> +};

Why are we testing only a single CPU model on each target (and
requiring one entry for each architecture in this table), instead
of just running query-cpu-definitions and testing all CPU models?

-- 
Eduardo
