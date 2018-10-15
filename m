Received: from eggs.gnu.org ([2001:4830:134:3::10]:33138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gC7Or-0006St-RI
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gC7Oj-00014v-K6
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:15:27 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gC7Og-0000yM-Aa
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:15:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id 206-v6so19891545wmb.5
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:15:16 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-20-alex.bennee@linaro.org>
	<ef760f1e-753f-a16c-760c-b717f94890b1@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <ef760f1e-753f-a16c-760c-b717f94890b1@linaro.org>
Date: Mon, 15 Oct 2018 19:15:13 +0100
Message-ID: <87in233wlq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 19/21] plugins: add an example
 hotblocks plugin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/5/18 8:49 AM, Alex Benn=C3=A9e wrote:
>> +char *plugin_status(void)
>> +{
>> +    GString *report =3D g_string_new("We have ");
>> +    char *r;
>> +    g_mutex_lock(&lock);
>> +    g_string_append_printf(report, "%ud entries in the hash table\n",
>> +                           g_hash_table_size(hotblocks));
>> +    g_mutex_unlock(&lock);
>> +    r =3D report->str;
>> +    g_string_free(report, FALSE);
>> +    return r;
>> +}
>
> You're not reporting the entries themselves?
> Also, are you sure you don't want to just return the GString?

I considered it. I wondered if exposing a glib dependency to the plugins
was fair game? It would make things simpler and QEMU could even allocate
it for the plugin.

>
>
> r~


--
Alex Benn=C3=A9e
