Received: from eggs.gnu.org ([2001:4830:134:3::10]:54178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo962-0005ld-Ki
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo95x-0002Fe-Vn
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:12:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo95x-0002F0-PW
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:12:53 -0400
References: <20180810132800.38549-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <904458f5-7eeb-649d-7aff-9d9ff6d75d64@redhat.com>
Date: Fri, 10 Aug 2018 10:12:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180810132800.38549-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] tests/libqtest: Improve kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, mst@redhat.com, f4bug@amsat.org, armbru@redhat.com, alex.bennee@linaro.org, rth@twiddle.net

On 08/10/2018 08:28 AM, Eric Blake wrote:
> Instead of using a raw assert, print the information in an
> easier to understand way:
> 
> /i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)

Well, it would help if my commit message actually matched...


> +        if (wstatus) {
> +            if (WIFEXITED(wstatus)) {
> +                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
> +                        "process but encountered exit status %d\n",
> +                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
> +            } else if (WIFSIGNALED(wstatus)) {
> +                int sig = WTERMSIG(wstatus);
> +                const char *signame = strsignal(sig) ?: "unknown ???";
> +                const char *dump = WCOREDUMP(wstatus) ? " (dumped core)" : "";
> +
> +                fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
> +                        "from signal %d (%s)%s\n",

...the code.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
