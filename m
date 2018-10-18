Received: from eggs.gnu.org ([2001:4830:134:3::10]:41838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9cQ-0004O6-VP
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9cN-0003VD-Np
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:49:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD9cN-0003Qy-El
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:49:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id n11-v6so33943684wru.13
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:49:43 -0700 (PDT)
References: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
	<2890bcd3-1ebf-7b56-f99a-cadf9f8be7d8@redhat.com>
	<20181018115742.7a5f840e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c5907ae-b888-2626-cc96-5d0339d6cdbe@redhat.com>
Date: Thu, 18 Oct 2018 16:49:40 +0200
MIME-Version: 1.0
In-Reply-To: <20181018115742.7a5f840e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] call HotplugHandler->plug() as the last
 step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On 18/10/2018 11:57, Igor Mammedov wrote:
> 
> I'm posting this first, so post_plug() won't confuse people and
> won't introduce a new code that would depend on it or even worse
> some plug handler would depend on plug() happening before reset.
> This patch should prevent that from happening. (Error** concerns
> are secondary here and I'll deal with it later on, hopefully
> during 3.2 cycle)
> 
> PS:
>  post_plug() is recurring idea which indicates that current plug()
>  is misplaced. (previous instance that's slipped in, was nvdimm's
>  75b0713e1 which was removed later on by c7f8d0f3a5).

Ok, queued.

Paolo
