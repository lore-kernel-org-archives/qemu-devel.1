Received: from eggs.gnu.org ([2001:4830:134:3::10]:55859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUZQn-0002kq-Ju
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUZQk-0003Yt-FJ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:40:41 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cUZQk-0003Xk-5B
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:40:38 -0500
Received: by mail-lf0-x244.google.com with SMTP id x1so8696911lff.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 05:40:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-10-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55000a0d-ee7a-1fbf-e88a-54c9cadcc344@redhat.com>
Date: Fri, 20 Jan 2017 14:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <1484759609-264075-10-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 09/13] numa: introduce '-numa cpu' cpu option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, Andrew Jones <drjones@redhat.com>, ehabkost@redhat.com, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, Thomas Huth <thuth@redhat.com>, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, David Gibson <david@gibson.dropbear.id.au>



On 18/01/2017 18:13, Igor Mammedov wrote:
> It allows to specify mapping of a CPU to NUMA node on CLI.
> Option should be repeated for each present/possible CPU.
> Example for PC machine:
>   -numa node,nodeid=0 -numa node,nodeid=1 \
>   -numa cpu,socket-id=0,core-id=0,thread-id=0,node-id=0 \
>   -numa cpu,socket-id=1,core-id=0,thread-id=0,node-id=1
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

What about making core-id/thread-id optional, like

-numa cpu,socket-id=0,node-id=0

?

Also perhaps change it like this to make it less verbose and match
"-numa node":

  -numa node,nodeid=0 -numa cpus,nodeid=0,socket=0 \
  -numa node,nodeid=1 -numa cpus,nodeid=1,socket=1

(Yeah, I know, bikeshedding).

Paolo
