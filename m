Received: from eggs.gnu.org ([2001:4830:134:3::10]:34658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYrGf-0004m0-WD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYrGc-0000Bn-Qb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:08:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYrGc-0000AY-KC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:08:42 -0400
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
	<65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
	<20180629130701.6ab5d88a@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29caab50-f853-66bf-805e-984e76619a9a@redhat.com>
Date: Fri, 29 Jun 2018 13:08:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180629130701.6ab5d88a@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29/06/2018 13:07, Greg Kurz wrote:
>>>> Also asserting current_machine != NULL is not necessary, since you're
>>>> immediately dereferencing it.  
>>> Is there a practical way to simply initialize the accelerators earlier
>>> in startup sequence, so we just remove or at least reduce, the liklihood
>>> of accessing it too early ?  
>> We can try, though not for 3.0 of course.
>>
> FWIW, the motivation for this patch was kvm_enabled() being called under
> the class_init function of the machine TypeInfo. This happens way earlier
> than accelerator init. Not sure this is doable, but I can have a look.
> 

Probably not, that's way too early indeed.

Paolo
