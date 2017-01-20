Received: from eggs.gnu.org ([2001:4830:134:3::10]:50472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUeRf-0005rB-00
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 14:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUeRa-0002zX-6V
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 14:01:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cUeRa-0002yg-1S
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 14:01:50 -0500
Date: Fri, 20 Jan 2017 17:01:44 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170120190144.GT3491@thinpad.lan.raisama.net>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484759609-264075-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [RFC 02/13] pc: cleanup: move smbios_set_cpuid()
 into pc_build_smbios()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

On Wed, Jan 18, 2017 at 06:13:18PM +0100, Igor Mammedov wrote:
> move smbios_set_cpuid() close to the rest of smbios init code
> where it belongs to instead of calling it from pc_cpus_init().
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Applying to machine-next. Thanks!

-- 
Eduardo
