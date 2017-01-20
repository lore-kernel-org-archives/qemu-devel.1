Received: from eggs.gnu.org ([2001:4830:134:3::10]:57334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUbCZ-0008NB-9s
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cUbCU-0004fD-PV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:34:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cUbCU-0004eg-Kw
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:34:02 -0500
Date: Fri, 20 Jan 2017 16:33:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170120163358.33a5c404@nial.brq.redhat.com>
In-Reply-To: <d6ddd2f5-9ebc-7e19-c904-6271b47f5c1d@cn.fujitsu.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-6-git-send-email-imammedo@redhat.com>
	<d6ddd2f5-9ebc-7e19-c904-6271b47f5c1d@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 05/13] pc: move pcms->possible_cpus init out
 of pc_cpus_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, ehabkost@redhat.com, fanc.fnst@cn.fujitsu.com, Thomas Huth <thuth@redhat.com>, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, David Gibson <david@gibson.dropbear.id.au>

On Fri, 20 Jan 2017 11:31:56 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> At 01/19/2017 01:13 AM, Igor Mammedov wrote:
> > possible_cpus could be initialized earlier then cpu objects,  
> 
> s/then/than/
ok,
I'll fix it on respin

> 
> > i.e. when -smp is parsed so move init code to possible_cpu_arch_ids()  
> 
> [...]
> 
> 
> 
