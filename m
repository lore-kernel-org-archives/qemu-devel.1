Received: from eggs.gnu.org ([2001:4830:134:3::10]:48072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1e4kLx-0006Qq-TY
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1e4kLu-00007Y-6U
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1e4kLu-00006P-0H
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:09:26 -0400
References: <20171018083305.5246-1-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <cfb8e3d0-7c4e-f83f-3887-18e6af8b0418@redhat.com>
Date: Wed, 18 Oct 2017 11:09:19 +0200
MIME-Version: 1.0
In-Reply-To: <20171018083305.5246-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tpm: Fix compilation with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com, Amarnath Valluri <amarnath.valluri@intel.com>

On 18/10/2017 10:33, Juan Quintela wrote:
> Commit
>    c37cacabf2285b0731b44c1f667781fdd4f2b658
> 
> broke compilation without tpm.  Just add an empty tpm_cleanup() stub.

tpm_init() and tpm_config_parse() are managed in a different way: they
are included in a "#ifdef CONFIG_TPM .. #endif" in vl.c

I think you should follow the same way.

Thanks,
Laurent
