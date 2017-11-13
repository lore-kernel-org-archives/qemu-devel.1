Received: from eggs.gnu.org ([2001:4830:134:3::10]:40392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEBYg-00033s-Gl
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEBYa-0004H7-Qo
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:01:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEBYa-0004GU-Kq
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:01:32 -0500
References: <20171106132805.19986-1-jfreimann@redhat.com>
	<ad15537b-8a7d-3bca-7ec2-fcd37eea7756@redhat.com>
	<CAFEAcA9PrgkZ-mFPU-uG8R+C4Ow87ifBbO34cmdWK0C4v1XGDA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b1d50747-f3c5-9419-4947-3e9293761faf@redhat.com>
Date: Mon, 13 Nov 2017 18:01:24 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9PrgkZ-mFPU-uG8R+C4Ow87ifBbO34cmdWK0C4v1XGDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net/socket: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jens Freimann <jfreimann@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>



On 2017=E5=B9=B411=E6=9C=8813=E6=97=A5 17:51, Peter Maydell wrote:
> On 13 November 2017 at 07:13, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2017=E5=B9=B411=E6=9C=8806=E6=97=A5 21:28, Jens Freimann wrote:
>>> This fixes coverity issue CID1005339.
>>>
>>> Make sure that saddr is not used uninitialized if the
>>> mcast parameter is NULL.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>>> ---
>>>    net/socket.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/socket.c b/net/socket.c
>>> index e6b471c63d..51eaea67a0 100644
>>> --- a/net/socket.c
>>> +++ b/net/socket.c
>>> @@ -332,7 +332,7 @@ static NetSocketState
>>> *net_socket_fd_init_dgram(NetClientState *peer,
>>>                                                    const char *mcast,
>>>                                                    Error **errp)
>>>    {
>>> -    struct sockaddr_in saddr;
>>> +    struct sockaddr_in saddr =3D { 0 };
>>>        int newfd;
>>>        NetClientState *nc;
>>>        NetSocketState *s;
>>> @@ -373,7 +373,7 @@ static NetSocketState
>>> *net_socket_fd_init_dgram(NetClientState *peer,
>>>        net_socket_read_poll(s, true);
>>>          /* mcast: save bound address as dst */
>>> -    if (is_connected) {
>>> +    if (is_connected && mcast !=3D NULL) {
>>>            s->dgram_dst =3D saddr;
>>>            snprintf(nc->info_str, sizeof(nc->info_str),
>>>                     "socket: fd=3D%d (cloned mcast=3D%s:%d)",
>>
>> Applied, thanks.
> Er, this version didn't pass code review and you should
> apply v2 instead...
>
> thanks
> -- PMM

Oops, indeed.

Apply V2.

Thanks
