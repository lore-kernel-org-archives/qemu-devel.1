Received: from eggs.gnu.org ([2001:4830:134:3::10]:35712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1ek8Dx-0001fS-A4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1ek8Dw-0007LH-CL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:56:17 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:33137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ramysameh26@gmail.com>)
	id 1ek8Dw-0007Kl-4y
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:56:16 -0500
Received: by mail-oi0-x234.google.com with SMTP id l8so6050254oig.0
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 04:56:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208115914.7df7bf87@redhat.com>
References: <CAF6HrYx6fKVAACMN1TFV_9xKU42RP1yULQpwjvV9jtDExZq8JA@mail.gmail.com>
	<20180208115914.7df7bf87@redhat.com>
From: Ramy Sameh <ramysameh26@gmail.com>
Date: Fri, 9 Feb 2018 14:56:14 +0200
Message-ID: <CAF6HrYxD6GU6PkYVt-weQPzdASRPe_myG3ANZ_4E0hNTQhAj=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Questions regarding how QEMU initializes virtual
 peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mona Safar <Mona.Safar@eng.asu.edu.eg>, Watheq <watheq@gmail.com>, Ahmed Aly <ahmedaly50@gmail.com>

Many thanks Igor for this valuable info.

On Thu, Feb 8, 2018 at 12:59 PM, Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 8 Feb 2018 12:06:44 +0200
> Ramy Sameh <ramysameh26@gmail.com> wrote:
>
> > Hello all,
> >
> > I am working with QEMU to simulate VersatilePB board.
> >
> > I am trying to understand how QEMU initialize the virtual peripherals
> (e.g.
> > UART, vectored Interrupt controller .. etc).
> >
> > When I traced the code, I found a function called "object_init_with_type"
> > in object.c, in which the function pointer "ti->instance_init(obj)" seems
> > to call the peripherals initialization functions.
> >
> > *I have couple of questions here:*
> > 1.) Some peripheral initialization functions are called multiple times
> such
> > as pl011_init, why is that ?
> function is called once for each instance of pl011 object.
>
> QEMU uses custom OOM framework (dubbed QOM), good point to start with it
> is probably to read doc comment in the beginning of include/qom/object.h
>
> Device objects are typically inherited from TYPE_DEVICE or its derivatives.
> Device init sequence typically looks like:
>    foo = object_new(TYPE_FOO);
>    // set_properties on foo, see object_property_set_...
>
>    // and set special property 'realize' which would call 'realize' method
>    object_property_set_bool(foo, true, "realized");
>
> See qdev_device_add() for details
>
> > 2.) Where is the entry point for the whole initialization functionalities
> > (that will eventually call "object_init_with_type")
>
> object_new() & co + object_initialize_with_type()
>
> > Thank you.
> >
>
>


-- 
Best Regards,
Ramy Sameh
Embedded Software Engineer
+2-010-172-777-14
