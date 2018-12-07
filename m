Received: from eggs.gnu.org ([2001:4830:134:3::10]:45386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVOa1-0007l5-3W
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 17:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVOZx-0004lH-Ti
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 17:26:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gVOZx-0004kn-3t
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 17:26:37 -0500
References: <20181207221417.5152-1-wainersm@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <928e3259-7b52-aafe-7898-a50e339cb832@redhat.com>
Date: Fri, 7 Dec 2018 16:26:30 -0600
MIME-Version: 1.0
In-Reply-To: <20181207221417.5152-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fixes to the check missing
 features routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: crosa@redhat.com, ccarrara@redhat.com

On 12/7/18 4:14 PM, Wainer dos Santos Moschetta wrote:
> The x86_cpu_class_check_missing_features() returns a list
> of unavailable features compared to the host CPU. Currently it may
> return empty strings for unamed features as well as duplicated

s/unamed/unnamed/

> names.
> 
> For example, the qmp "query-cpu-definitions" below shows one empty
> string and repeated "mpx" entries:

> +++ b/target/i386/cpu.c
> @@ -3615,19 +3615,29 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>   
>       x86_cpu_filter_features(xc);
>   
> +    /* Uses an auxiliar dictionary to ensure the list of features has not

s/auxiliar/auxiliary/

> +       repeated name. */
> +    QDict *unique_feats_dict = qdict_new();
> +

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
