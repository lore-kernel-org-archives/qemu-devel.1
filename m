Received: from eggs.gnu.org ([209.51.188.92]:46012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1GCL-00083r-SQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1GCL-0000Bw-18
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:57:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1GCJ-00007r-QF
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:57:56 -0500
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
	<0ac05885-96d6-9355-0333-31a909fd943b@redhat.com>
	<CAGZZdDEp7vxzxbWoHn5AF3g28FKSwka1WQB=U5MTv6X=XLeL7A@mail.gmail.com>
	<3249d2a0-f981-9da1-c4a0-f61dc0acd66d@redhat.com>
	<CAGZZdDH1CvhvJ7ZoCGgc8wYgk01ePn_7VnWdacaEkRVNSMTxvA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f1615fd-6cb7-2959-aae5-e811286e95b3@redhat.com>
Date: Tue, 5 Mar 2019 13:57:52 -0600
MIME-Version: 1.0
In-Reply-To: <CAGZZdDH1CvhvJ7ZoCGgc8wYgk01ePn_7VnWdacaEkRVNSMTxvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset,
 make -p and -c boolean (no arg)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: unai.martinezcorral@ehu.eus
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu

On 3/5/19 1:36 PM, Unai Martinez Corral wrote:
> 2019/3/5 17:57, Eric Blake:
>> You are correct that 'printf -1' is likely to fail, 'printf -- -1' is
>> portable but unusual, and 'printf %s\\n -1' is identical to the common
>> (but non-portable) behavior of 'echo -1'. Is the newline important?
> 
> In this case, the newline seems not to be relevant. I find 'printf --
> -1' elegant, but since I already submitted v2 of the patch, I think
> the difference compared to 'printf %s -1' is not worth a new version.
> Please, let me know if you feel otherwise.

I don't have a strong preference between the two forms - so this is your 
chance to assert your creative liberty. But I don't know enough about 
binfmt_misc to know if the newline matters. I'm just reviewing on the 
basis of shell portability, and hope that other reviewers more familiar 
with binfmt will review on content. That said, I already have enough 
other comments on v2 that you may want to split this into a series of 
patches for v3, although you could also wait a day or so to see if 
anyone else reviews and minimize the list churn.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
