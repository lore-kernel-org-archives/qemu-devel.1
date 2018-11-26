Received: from eggs.gnu.org ([2001:4830:134:3::10]:36738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gR4rw-0004i9-QO
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gR4rt-0000fv-6r
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:35:20 -0500
Received: from steffen-goertz.de ([88.198.119.201]:38834)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gR4rt-0000fT-0V
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:35:17 -0500
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-8-contrib@steffen-goertz.de>
	<3b9c8331-c84a-414a-8ff3-905a9e4b3779@redhat.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <9768c404-0fb5-0128-0902-35979df95669@steffen-goertz.de>
Date: Sun, 25 Nov 2018 19:35:13 -0500
MIME-Version: 1.0
In-Reply-To: <3b9c8331-c84a-414a-8ff3-905a9e4b3779@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 07/14] tests: Add bbc:microbit / nRF51
 test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

Hi Thomas,

thank you for your remarks!

>> +int main(int argc, char **argv)
>> +{
>> +    int ret;
>> +
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    global_qtest = qtest_initf("-machine microbit");
>> +
>> +    qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
>> +
>> +    ret = g_test_run();
>> +
>> +    qtest_quit(global_qtest);
>> +    return ret;
>> +}
> 
> If you could do me a big favour, then please try to write new qtests
> without the global_qtest variable. I.e. move the qtest_initf into the
> test_nrf51_nvmc function and pass around the local test state variable
> there to qtest_writel() and friends. I just started yet another clean up
> attempt for some other files, e.g. see here:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02196.html
> 
> (but if this is too much cumbersome right now for you, I also won't
> object this patch in the current shape - we can still clean this up later)
> 

I would like to leave the test like this at the moment. We will add additional devices in the future and i would like to postpone refactoring of the test until the current patch series is merged.

Best,
Steffen
