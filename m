Received: from eggs.gnu.org ([2001:4830:134:3::10]:37967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffSNM-0001KR-Jg
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffSNJ-0002yD-Fs
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:58:56 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:36092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ffSNJ-0002xV-7l
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:58:53 -0400
Received: by mail-pg1-x535.google.com with SMTP id m19-v6so636330pgv.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:58:52 -0700 (PDT)
References: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
	<1531809130-31088-2-git-send-email-junyan.he@gmx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <918a4e6b-f781-5bb3-0f67-052a5548ad19@linaro.org>
Date: Tue, 17 Jul 2018 08:58:49 -0700
MIME-Version: 1.0
In-Reply-To: <1531809130-31088-2-git-send-email-junyan.he@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7 V10] memory,
 exec: Expose all memory block related flags.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>

On 07/16/2018 11:32 PM, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
> 
> We need to use these flags in other files rather than just in exec.c,
> For example, RAM_SHARED should be used when create a ram block from file.
> We expose them the exec/memory.h
> 
> Signed-off-by: Junyan He <junyan.he@intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  exec.c                | 20 --------------------
>  include/exec/memory.h | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
