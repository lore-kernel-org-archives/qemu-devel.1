Received: from eggs.gnu.org ([2001:4830:134:3::10]:36952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9sWc-0005Uz-66
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9sWW-0007Ds-St
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:58:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9sWW-0007CC-MT
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:58:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so11114274wmf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 06:58:08 -0700 (PDT)
References: <1539002382-3764-1-git-send-email-thuth@redhat.com>
	<038b8279-f8c1-4158-e750-93f981508aed@redhat.com>
	<27e18d16-4dc5-b6e5-fa79-4977203dcfe3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a2058c6b-aa9c-ee45-c60b-289b109f89f4@redhat.com>
Date: Tue, 9 Oct 2018 15:58:05 +0200
MIME-Version: 1.0
In-Reply-To: <27e18d16-4dc5-b6e5-fa79-4977203dcfe3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/ppc/spapr_rng: Introduce
 CONFIG_SPAPR_RNG switch for spapr_rng.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

On 09/10/2018 15:27, Thomas Huth wrote:
> On 2018-10-09 13:45, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 08/10/2018 14:39, Thomas Huth wrote:
>>> The spapr-rng device is suboptimal when compared to virtio-rng, so
>>> users might want to disable it in their builds. Thus let's introduce
>>> a proper CONFIG switch to allow us to compile QEMU without this device.
>>> The function spapr_rng_populate_dt is required for linking, so move it
>>> to a different location.
>>
>> Without CONFIG_SPAPR_RNG this function is not reachable, can you use a
>> stub instead?
> 
> I'd like to avoid stubs if possible. stubs are fine if there is no easy
> other solution, but they are a little bit confusing ("which of these
> functions is now linked into the executable?"), so in case there is no
> urgent need, it's IMHO way nicer to get along without them. In this
> case, there is no real urgent need - the function is just small, and
> does not have any other dependencies into the disabled code, so why
> should we complicate things here and introduce a stub?

In this case this is fair enough because this function uses the same API
than the surrounding functions (no extra headers/libs required).

[I just read v1 comments on this series]

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
