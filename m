Received: from eggs.gnu.org ([2001:4830:134:3::10]:54369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBZ9-0007go-6z
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBZ8-0006lh-E6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:18:15 -0500
Date: Tue, 6 Feb 2018 20:18:05 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180206221805.GC13301@localhost.localdomain>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
	<1516694904-64879-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516694904-64879-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/25] arm: cpu: add CPU_RESOLVING_TYPE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Tue, Jan 23, 2018 at 09:08:02AM +0100, Igor Mammedov wrote:
> it will be used for providing to cpu name resolving class for
> parsing cpu model for system and user emulation code.
> 
> Along with change add target to null-machine test, so
> that when switch to CPU_RESOLVING_TYPE happens,
> thest would ensure that null-mchine usecase still works.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
[...]
> @@ -4325,8 +4325,6 @@ int main(int argc, char **argv, char **envp)
>  #else
>          cpu_model = "qemu32";
>  #endif
> -#elif defined(TARGET_ARM)
> -        cpu_model = "any";

I don't see any explanation for this hunk in the commit message.


>  #elif defined(TARGET_UNICORE32)
>          cpu_model = "any";
>  #elif defined(TARGET_M68K)
[...]

-- 
Eduardo
