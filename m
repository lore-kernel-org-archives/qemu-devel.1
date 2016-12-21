Received: from eggs.gnu.org ([2001:4830:134:3::10]:37214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJij2-0007r3-9k
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 10:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJiiy-000213-DE
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 10:22:40 -0500
Date: Wed, 21 Dec 2016 13:22:26 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161221152226.GH3808@thinpad.lan.raisama.net>
References: <20161201170624.26496-1-lersek@redhat.com>
	<148227487620.73.10055858460424473693@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148227487620.73.10055858460424473693@790289a7ca88>
Subject: [Qemu-devel] checkpatch.pl false positive (was Re: [PATCH v4 0/7]
 q35: add negotiable broadcast SMI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, famz@redhat.com, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, zhaoshenglong@huawei.com, michael@walle.cc, qemu-arm@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, Dec 20, 2016 at 03:01:17PM -0800, no-reply@patchew.org wrote:
[...]
> Checking PATCH 4/7: hw/i386/pc: introduce 2.9 machine types with 0x20 fw_cfg file slots...
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #126: FILE: include/hw/compat.h:4:
> +#define HW_COMPAT_2_8 \
> +    {\
> +        .driver   = "fw_cfg_mem",\
> +        .property = "file_slots",\
> +        .value    = stringify(0x10),\
> +    },{\
> +        .driver   = "fw_cfg_io",\
> +        .property = "file_slots",\
> +        .value    = stringify(0x10),\
> +    },
> 
> total: 1 errors, 0 warnings, 119 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

It is a false positive, but how exactly can we fix it? Should it
become a warning instead of an error?

-- 
Eduardo
