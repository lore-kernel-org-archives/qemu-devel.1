Received: from eggs.gnu.org ([2001:4830:134:3::10]:34869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTfZC-0002SX-Tt
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTfZ9-0006SD-QN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:38:26 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTfZ9-0006Ro-Gi
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:38:23 -0400
Received: by mail-pf0-x244.google.com with SMTP id a22-v6so4214059pfo.12
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 20:38:23 -0700 (PDT)
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
	<20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
	<ea3044c2-d8cd-d41d-91a6-5d78bff86e76@linaro.org>
	<20180615000020.2a3372a5@bahia.lan>
	<20180615014501.GI4129@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a1e00ab-5b80-0402-4335-cc340ba6b582@linaro.org>
Date: Thu, 14 Jun 2018 17:38:16 -1000
MIME-Version: 1.0
In-Reply-To: <20180615014501.GI4129@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR
 values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/14/2018 03:45 PM, David Gibson wrote:
>>> To wit, the instructions are recognized and transactions always fail.  Which is
>>> not a bad way to test the required fallback paths that rarely fail on hardware.
>>>  ;-)
>>
>> If TM instructions don't cause an exception, I guess its reasonable to say
>> they're supported :)
> 
> That argument has come up before, and I disagree.  I don't think it's
> reasonable to advertise TM support as available if the instructions
> always fail.

Is it possible to turn it on from the command-line?
Like one can with -cpu foo,+opt on x86 or -cpu foo,opt=on on s390?


r~
