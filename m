Received: from eggs.gnu.org ([2001:4830:134:3::10]:42707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwca0-0004ww-P6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcZw-0008To-Pc
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:14:24 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:54515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwcZw-0008TZ-IS
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:14:20 -0400
Received: by mail-pg0-x22e.google.com with SMTP id c137so4870036pga.11
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:14:20 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f5df52db-c3b7-538c-a859-345b87a9b9b4@linaro.org>
Date: Mon, 25 Sep 2017 16:14:16 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/27] target/s390x: get rid of
 next_core_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/18/2017 08:59 AM, David Hildenbrand wrote:
>      /* sync cs->cpu_index and env->core_id. The latter is needed for TCG. */
> -    cs->cpu_index = env->core_id;
> +    cs->cpu_index = cpu->env.core_id;
> +#endif

Any reason not to drop core_id entirely in favour of cpu_index?
(Since cpu_index itself is generic and can't be dropped.)


r~
