Received: from eggs.gnu.org ([2001:4830:134:3::10]:41148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKUEA-0002fH-Pm
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKUE9-0006Se-Pa
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:05:58 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKUE9-0006SQ-Kb
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:05:57 -0500
Received: by mail-pf0-x244.google.com with SMTP id 127so4234408pfg.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 10:05:57 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <148243173750.7321.8231977784466776952.stgit@fimbulvetr.bsc.es>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cf19ab2b-ef52-9fa3-dea8-662c4513379c@twiddle.net>
Date: Fri, 23 Dec 2016 10:05:53 -0800
MIME-Version: 1.0
In-Reply-To: <148243173750.7321.8231977784466776952.stgit@fimbulvetr.bsc.es>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] trace: [tcg] Optimize per-vCPU
 tracing states with separate TB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 12/22/2016 10:35 AM, Lluís Vilanova wrote:
> To handle both issues, this series replicates the shared physical TB cache,
> creating a separate physical TB cache for every combination of event states
> (those with the 'vcpu' and 'tcg' properties). Then, all vCPUs tracing the same
> events will use the same physical TB cache.

Why do we need to "split the physical TB cache" as opposed to simply including
the trace state into the TB hash function?


r~
