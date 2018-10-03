Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7Ub7-00072C-Ug
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7Ub4-0000gm-L4
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:01:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7Ub4-0000gg-Eb
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 20:00:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so3923900wme.3
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 17:00:58 -0700 (PDT)
References: <20180928003058.12786-1-philmd@redhat.com>
	<20180928003058.12786-2-philmd@redhat.com>
	<3642a22b-6132-690b-b6af-58cf0dd12bdc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3931e520-45e8-97c3-7efc-6323de106581@redhat.com>
Date: Wed, 3 Oct 2018 02:00:55 +0200
MIME-Version: 1.0
In-Reply-To: <3642a22b-6132-690b-b6af-58cf0dd12bdc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] acceptance tests: Add SeaBIOS boot
 and debug console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 10/3/18 1:26 AM, Cleber Rosa wrote:
[...]
>> +    :avocado: enable
>> +    :avocado: tags=x86_64,quick
> 
> Eventually, we'll need to have a predictable definition to, at least,
> some of the tags.  I mean, I agree this *should* be a quick by test
> (considering it's a functional test), but eventually we may want to set
> some ranges for what we consider "quick", "slow" or "I'm gonna take my
> time, don't wait on me". :)

Maybe we can set a timeout tag and let the user choose how long he is
willing to wait:

   :avocado: max_time=20s

>> +    """
>> +
>> +    timeout = 15
>> +
>> +    def test_seabios(self):
[...]
