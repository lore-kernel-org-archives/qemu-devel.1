Received: from eggs.gnu.org ([2001:4830:134:3::10]:46559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fV2RK-0000yF-M2
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fV2RH-00062b-HD
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:15:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fV2RH-00062I-CO
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:15:55 -0400
References: <152899585150.702.2589994392500110079@d39dc562802a>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d78e8f55-5527-1d8f-c38b-bcbcbb5ef381@redhat.com>
Date: Mon, 18 Jun 2018 17:15:53 -0500
MIME-Version: 1.0
In-Reply-To: <152899585150.702.2589994392500110079@d39dc562802a>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix compilation with python-3 if
 en_US.UTF-8 is unavailable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, tamiko@43-1.org
Cc: famz@redhat.com, ehabkost@redhat.com

On 06/14/2018 12:04 PM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 

>    GEN     qemu-options.def
>    GEN     qapi-gen
>    GEN     trace/generated-tcg-tracers.h
> /var/tmp/patchew-tester-tmp-j902xtzn/src/qapi/qapi-schema.json:56: Pragma returns-whitelist must be a list of strings

Your idea makes sense (force the encoding in our scripts that care about 
encoding, rather than via the environment), but you'll need to resolve 
this build failure first.  Looking forward to v2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
