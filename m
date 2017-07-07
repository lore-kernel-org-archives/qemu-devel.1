Received: from eggs.gnu.org ([2001:4830:134:3::10]:60886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTS35-0001I8-Fv
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTS30-0007tb-G1
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dTS30-0007tH-7B
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:07:46 -0400
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
	<bf86d70d-2518-676d-8ac7-63fb4646449e@redhat.com>
	<20170707115849.GP12152@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0919a4dd-bae4-f124-fde1-3aa3d968813c@redhat.com>
Date: Fri, 7 Jul 2017 14:07:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170707115849.GP12152@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/6] Convert error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Rob Herring <robh@kernel.org>, Josh Durgin <jdurgin@redhat.com>, armbru@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>, philippe@mathieu-daude.net, Peter Lieven <pl@kamp.de>, Greg Kurz <groug@kaod.org>, Peter Chubb <peter.chubb@nicta.com.au>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Igor Mammedov <imammedo@redhat.com>, alistair23@gmail.com, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 07.07.2017 13:58, Eduardo Habkost wrote:
> On Fri, Jul 07, 2017 at 08:33:19AM +0200, Thomas Huth wrote:
>> On 07.07.2017 01:49, Alistair Francis wrote:
>>> Convert all uses of error_report("[Ww]arning:"... to use warn_report()
>>> instead. This helps standardise on a single method of printing warnings
>>> to the user.
>>>
>>> All of the warnings were found using this regex expression:
>>>     error_report.*[Ww]arning:
>>> and replaced with:
>>>     warn_report("
>> [...]
>>> diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
>>> index 48e5b7315f..b25fe892ed 100644
>>> --- a/tests/test-qdev-global-props.c
>>> +++ b/tests/test-qdev-global-props.c
>>> @@ -232,10 +232,10 @@ static void test_dynamic_globalprop(void)
>>>      g_test_trap_assert_passed();
>>>      g_test_trap_assert_stderr_unmatched("*prop1*");
>>>      g_test_trap_assert_stderr_unmatched("*prop2*");
>>> -    g_test_trap_assert_stderr("*Warning: global dynamic-prop-type-bad.prop3 has invalid class name\n*");
>>> +    g_test_trap_assert_stderr("*warning: global dynamic-prop-type-bad.prop3 has invalid class name\n*");
>>>      g_test_trap_assert_stderr_unmatched("*prop4*");
>>> -    g_test_trap_assert_stderr("*Warning: global nohotplug-type.prop5=105 not used\n*");
>>> -    g_test_trap_assert_stderr("*Warning: global nondevice-type.prop6 has invalid class name\n*");
>>> +    g_test_trap_assert_stderr("*warning: global nohotplug-type.prop5=105 not used\n*");
>>> +    g_test_trap_assert_stderr("*warning: global nondevice-type.prop6 has invalid class name\n*");
>>>      g_test_trap_assert_stdout("");
>>>  }
>>
>> These changes are unrelated ... please drop them from your patch.
> 
> Are they?  I believe they are necessary so the test case won't be
> broken by the qdev-properties.c changes.

Ah, right, of course. I was so much focused on looking at warn_report()
that I did not notice that this hunk here is about adapting the
corresponding *test* ... so never mind - sorry for the noise!

 Thomas
