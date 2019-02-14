Received: from eggs.gnu.org ([209.51.188.92]:41689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guHxe-0002Ru-BE
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guHm0-0002oh-Lq
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:13:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1guHly-0002gr-M4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:13:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id c8so6641277wrs.4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 06:13:50 -0800 (PST)
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <6b51c177-b24e-4838-b477-3132f133dcf5@gmail.com>
Date: Thu, 14 Feb 2019 16:14:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190213065357.16076-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/9] Misc fixes to pvrdma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dgilbert@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Hi Yuval,

On 2/13/19 8:53 AM, Yuval Shaia wrote:
> Hi,
> Please review the following patch-set which consist of cosmetics fixes to
> device's user interface (traces, error_report and monitor) and some bug
> fixes.
>
> Thanks Markus, Eric, Marcel and David for reviewing v0.
> Appreciate your review to this v2.

clang compilation fails.
Please use this configuration:

     configure --target-list="x86_64-softmmu" --cc=clang --enable-pvrdma

It will fail with:

In file included from 
/home/mapfelba/git/upstream/qemu/hw/rdma/rdma_backend.c:32:
In file included from /home/mapfelba/git/upstream/qemu/hw/rdma/rdma_rm.h:21:
/home/mapfelba/git/upstream/qemu/hw/rdma/rdma_rm_defs.h:108:3: error: 
redefinition of typedef 'RdmaDeviceResources' is a C11 feature 
[-Werror,-Wtypedef-redefinition]
} RdmaDeviceResources;
   ^
/home/mapfelba/git/upstream/qemu/hw/rdma/rdma_backend_defs.h:24:36: 
note: previous definition is here
typedef struct RdmaDeviceResources RdmaDeviceResources;
                                    ^
1 error generated.
make[1]: *** [/home/mapfelba/git/upstream/qemu/rules.mak:69: 
hw/rdma/rdma_backend.o] Error 1
make[1]: *** Waiting for unfinished jobs....
In file included from /home/mapfelba/git/upstream/qemu/hw/rdma/rdma_rm.c:21:
In file included from 
/home/mapfelba/git/upstream/qemu/hw/rdma/rdma_backend.h:22:
/home/mapfelba/git/upstream/qemu/hw/rdma/rdma_rm_defs.h:108:3: error: 
redefinition of typedef 'RdmaDeviceResources' is a C11 feature 
[-Werror,-Wtypedef-redefinition]
} RdmaDeviceResources;
   ^
/home/mapfelba/git/upstream/qemu/hw/rdma/rdma_backend_defs.h:24:36: 
note: previous definition is here
typedef struct RdmaDeviceResources RdmaDeviceResources;
                                    ^
1 error generated.
make[1]: *** [/home/mapfelba/git/upstream/qemu/rules.mak:69: 
hw/rdma/rdma_rm.o] Error 1
In file included from 
/home/mapfelba/git/upstream/qemu/hw/rdma/vmw/pvrdma_qp_ops.c:19:
In file included from 
/home/mapfelba/git/upstream/qemu/hw/rdma/vmw/../rdma_rm.h:21:
/home/mapfelba/git/upstream/qemu/hw/rdma/vmw/../rdma_rm_defs.h:108:3: 
error: redefinition of typedef 'RdmaDeviceResources' is a C11 feature 
[-Werror,-Wtypedef-redefinition]
} RdmaDeviceResources;
   ^
/home/mapfelba/git/upstream/qemu/hw/rdma/vmw/../rdma_backend_defs.h:24:36: 
note: previous definition is here
typedef struct RdmaDeviceResources RdmaDeviceResources;
                                    ^
1 error generated.
make[1]: *** [/home/mapfelba/git/upstream/qemu/rules.mak:69: 
hw/rdma/vmw/pvrdma_qp_ops.o] Error 1
In file included from 
/home/mapfelba/git/upstream/qemu/hw/rdma/vmw/pvrdma_cmd.c:23:
In file included from 
/home/mapfelba/git/upstream/qemu/hw/rdma/vmw/../rdma_backend.h:22:
/home/mapfelba/git/upstream/qemu/hw/rdma/vmw/../rdma_rm_defs.h:108:3: 
error: redefinition of typedef 'RdmaDeviceResources' is a C11 feature 
[-Werror,-Wtypedef-redefinition]
} RdmaDeviceResources;
   ^
/home/mapfelba/git/upstream/qemu/hw/rdma/vmw/../rdma_backend_defs.h:24:36: 
note: previous definition is here
typedef struct RdmaDeviceResources RdmaDeviceResources;
                                    ^

Thanks,
Marcel
