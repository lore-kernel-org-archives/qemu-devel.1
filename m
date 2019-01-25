Received: from eggs.gnu.org ([209.51.188.92]:37869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmwr2-0007ah-Mt
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gmwbV-0005bY-Ta
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:12:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gmwbR-0005XI-R4
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 03:12:44 -0500
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
	<CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
	<64411f3f-0071-fc94-945c-af16cf5edc77@redhat.com>
	<20190123195345.GI2193@work-vm>
	<a0c711c1-17d4-9fbe-b78c-4cd4a2419633@redhat.com>
	<877eeuidzp.fsf@dusky.pond.sub.org>
	<9cbb73bc-dbe2-4f5b-56e4-4c733811ed54@redhat.com>
	<87a7jptdla.fsf@dusky.pond.sub.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c5c6c8cb-0cfd-323e-a291-f098ea4b8ec2@redhat.com>
Date: Fri, 25 Jan 2019 16:12:24 +0800
MIME-Version: 1.0
In-Reply-To: <87a7jptdla.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] test-filter-mirror hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


On 2019/1/25 =E4=B8=8B=E5=8D=883:12, Markus Armbruster wrote:
> Jason Wang <jasowang@redhat.com> writes:
>
>> On 2019/1/24 =E4=B8=8B=E5=8D=885:47, Markus Armbruster wrote:
>>> Please cc: me on QMP issues.
>>
>> Ok.
>>
>>
>>> Jason Wang <jasowang@redhat.com> writes:
>>>
>>>> On 2019/1/24 =E4=B8=8A=E5=8D=883:53, Dr. David Alan Gilbert wrote:
>>>>> * Jason Wang (jasowang@redhat.com) wrote:
>>>>>> On 2019/1/22 =E4=B8=8A=E5=8D=882:56, Peter Maydell wrote:
>>>>>>> On Thu, 17 Jan 2019 at 09:46, Jason Wang<jasowang@redhat.com>  wr=
ote:
>>>>>>>> On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
>>>>>>>>> On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
>>>>>>>>> <dgilbert@redhat.com  <mailto:dgilbert@redhat.com>> wrote:
>>>>>>>>>
>>>>>>>>>         * Peter Maydell (peter.maydell@linaro.org
>>>>>>>>>         <mailto:peter.maydell@linaro.org>) wrote:
>>>>>>>>>         > Recently I've noticed that test-filter-mirror has bee=
n hanging
>>>>>>>>>         > intermittently, typically when run on some other TCG =
architecture.
>>>>>>>>>         > In the instance I've just looked at, this was with s3=
90x guest on
>>>>>>>>>         > x86-64 host, though I've also seen it on other host a=
rchs and
>>>>>>>>>         > perhaps with other guests.
>>>>>>>>>
>>>>>>>>>         Watch out to see if you really do see it for other gues=
ts;
>>>>>>>>>         it carefully avoids using virtio-net to avoid vhost; bu=
t on s390x it
>>>>>>>>>         uses virtio-net-ccw - could that hit the vhost it was t=
rying to avoid?
>>>>>>>>>
>>>>>>>>>         > Below is a backtrace, though it seems to be pretty un=
helpful.
>>>>>>>>>         > Anybody got any theories ? Does the mirror test rely =
on dirty
>>>>>>>>>         > memory bitmaps like the migration test (which also ha=
ngs
>>>>>>>>>         > occasionally with TCG due to some bug I'm sure we've =
investigated
>>>>>>>>>         > in the past) ?
>>>>>>>>>
>>>>>>>>>         I don't think it relies on the CPU at all.
>>>>>>>>>      I have no idea about this currently, but Jason and I desig=
ned the
>>>>>>>>> test case.
>>>>>>>>> Add Jason: Have any comments about this ?
>>>>>>>> I can't reproduce this locally with s390x-softmmu. It looks to m=
e the
>>>>>>>> test should be independent to any kinds of emulation. It should =
pass
>>>>>>>> when mainloop work.
>>>>>>> I've just seen a hang with ppc64 guest on s390x host, so it is
>>>>>>> indeed not specific to s390x guest (and so not specific to
>>>>>>> virtio-net either, since the ppc64 guest setup uses e1000).
>>>>>>>
>>>>>>> thanks
>>>>>>> -- PMM
>>>>>> Finally reproduced locally after hundreds (sometimes thousands) ti=
mes of
>>>>>> running.
>>>>>>
>>>>>> Bisection points to OOB monitor[1].
>>>>>>
>>>>>> It looks to me after OOB is used unconditionally we lose a barrier=
 to make
>>>>>> sure socket is connected before sending packets in test-filter-mir=
ror.c. Is
>>>>>> there any other similar and simple thing that we could do to kick =
the
>>>>>> mainloop?
>>>>> Do you mean the:
>>>>>
>>>>>        /* send a qmp command to guarantee that 'connected' is setti=
ng to true. */
>>>>>        qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
>>>> Yes.
>>>>
>>>>
>>>>> why was that ever sufficient to know the socket was ready?
>>>> It was suggested by Fam, I don't remember the details. Can we make
>>>> sure all pending events has been processed (UNIX socket was set to
>>>> connected) after query-status is returned with an non OOB monitor?
>>> I'm afraid I lack context.  Which socket are you talking about?  The
>>> test has at least the QMP socket, the send_sock[], and recv_sock.  Wh=
at
>>> exactly are you trying to accomplish?
>>
>> I mean recv_sock. If mirror tries to send a packet to it before its
>> is_connected is set to true, packet will be dropped.
> So the *socket* is connected (in the TCP sense),


UNIX domain socket actually in the case of this test.


> but something else
> (whatever owns is_connected) is not.  Can you point me to where
> is_connected is set to true?


Sorry, should be "connected". It was set in tcp_chr_connect(). So if=20
filter want to send a packet to socket chardev before tcp_chr_connect()=20
is called, the packet will be dropped silently by tcp_chr_write(). This=20
will fail this unit-test.


>
>>> By the way, mkstemp(sock_path) followed by unix_connect(sock_path, NU=
LL)
>>> looks rather fishy.  Why create a temporary file only to create a Uni=
x
>>> domain socket right over it?
>>
>> I vaguely remember passing fd created by unix domain socket doesn't
>> work when the test is introduced. So my understanding is the author
>> needs a way to create a unique file name which will be used b Unix
>> domain socket at that time.
> We should really, really, really improve the test harness to run each
> test program in its very own temporary directory.  Then tests can simpl=
y
> create files with fixed names, and leave cleanup to the test harness.


Agree, but for this test, since passing fd works now. I tend to using=20
socketpair().


>>>    Why is ignoring errors a good idea?
>>
>> I don't get, which error is missed, it checks the return value of both
>> mkstemp() and unix_connect().
> Now I neglected to provide enough context for you :)
>
> I read
>
>      recv_sock =3D unix_connect(sock_path, NULL);
>
> and immediately went "why are errors ignored".  If I had read on (as I
> should've), I would've seen the are not:
>
>      g_assert_cmpint(recv_sock, !=3D, -1);
>
> Sorry for the noise.
>
> I'd replace both lines by
>
>      recv_sock =3D unix_connect(sock_path, &error_abort);
>
> Reports the actual error, which is an obvious improvement, with the
> location pointing to the failing spot within unix_connect().  To find
> where unix_connect() was called, you need to examine the stack
> backtrace.  Strictly more information, but your actual mileage may vary=
.
>

I see.

Thanks.
