Received: from eggs.gnu.org ([2001:4830:134:3::10]:53262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBUc-0004py-TC
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBUb-00075B-Ud
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:13:34 -0500
Date: Tue, 6 Feb 2018 20:13:25 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180206221325.GB13301@localhost.localdomain>
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
> ---
> v2:
>   - rename file to machine-none-test.c (Thomas Huth <thuth@redhat.com>)
>   - use qtest_startf()/instead of qtest_start() (Thomas Huth <thuth@redhat.com>)
[...]
> +static struct arch2cpu cpus_map[] = {
> +    /* tested targets list */
> +};
[...]
> +static void test_machine_cpu_cli(void)
> +{
> +    QDict *response;
> +    const char *arch = qtest_get_arch();
> +    const char *cpu_model = get_cpu_model_by_arch(arch);
> +
> +    if (!cpu_model) {
> +        fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
> +                " add it to cpus_map\n", arch);
> +        return; /* TODO: die here to force all targets have a test */
> +    }

I'm unsure if it's OK to purposefully have intermediate commits
that will generate warnings on "make check".  It could confuse
people doing bisects.

I would prefer to add this warning only after all targets are
converted.  Or maybe only add this test code after all targets
are converted.

-- 
Eduardo
