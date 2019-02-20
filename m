Received: from eggs.gnu.org ([209.51.188.92]:50554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVvp-0002Sy-WC
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVvm-0002yy-5h
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:45:17 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwVvk-0002vf-72
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:45:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id q187so7522172wme.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:45:10 -0800 (PST)
References: <20190220104523.22059-1-pbonzini@redhat.com>
	<87o9764dsb.fsf@zen.linaroharston>
	<b3fe812b-62ac-4b28-416b-4780e11528c0@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b3fe812b-62ac-4b28-416b-4780e11528c0@redhat.com>
Date: Wed, 20 Feb 2019 17:45:08 +0000
Message-ID: <87lg2a4amz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] shippable: fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/20/19 5:37 PM, Alex Benn=C3=A9e wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> It looks like something in netmap has changed and compilation fails:
>>>
>>>    install -D libnetmap.a //usr/local/lib/libnetmap.a
>>>    install: cannot stat libnetmap.a: No such file or directory
>>>
>>> Add an explicit "make" step to fix it.
>>
>> I took an alternate approach as tracking another projects master seems
>> like a bad idea:
>>
>> tests/docker: peg netmap code to a specific version
>>
>> Tracking head is always going to be at the whims of the upstream.
>> Let's use a defined release so things don't magically change under us.
>
> Oh now I see your reply...
>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> 1 file changed, 1 insertion(+)
>> tests/docker/dockerfiles/debian-amd64.docker | 1 +
>>
>> modified   tests/docker/dockerfiles/debian-amd64.docker
>> @@ -33,6 +33,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>>      apt-get install -y --no-install-recommends \
>>          linux-headers-amd64
>>  RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
>> +RUN cd /usr/src/netmap && git checkout v11.3
>
> ... and I notice I forgot to change directory in my previous suggestion.
>
> Why do you take v11.3 and not v11.4?
> I agree v11.3 was closer to what I tested when I introduced this
> dependency, but I'd rather use the latest release.

Hmm github hid the newer releases by default and has a Latest Release
button by v11.3.

--
Alex Benn=C3=A9e
