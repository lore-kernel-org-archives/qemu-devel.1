Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFEDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128DF20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128DF20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joS0H-0001qg-BH
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lma@suse.com>) id 1joRz0-0000CE-Q7
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:32:02 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:51119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lma@suse.com>) id 1joRyy-0005tk-Iu
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:32:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2057.outbound.protection.outlook.com [104.47.12.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-z5-pTPbIOp6BtpaoW9Nfkw-1; Thu, 25 Jun 2020 15:31:57 +0200
X-MC-Unique: z5-pTPbIOp6BtpaoW9Nfkw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/Wu3RHqPp4mokWfVJIQ00mj/K8GJR+YHyUUe63IGdRbFPOHozrTMvtZqEMGPMELL8V0V7YFN7C3Wuig3IvT0oZ9NWpwIx7D5pw59R+aw7xA9MsFwsKQtZheJBvnLPpydYdEKb8oy1RsDvzEqujmDVpKxH0GR87dDXSkssC/kjpZbUh+4tE9WzQisYoeDha+eDBXL9sN0kBEb7o4q9zEr1awVDPygJk9E1IbBgYULAPxg0JJv0UV5jnDzTYeKbJodrKe9waZzNT00M/ElVLIc9uVhXGg1Lu8JMZBWCAAcGy1U13o7PiDPQhjHjftQDvWgAsJEIboOG/AawfaVWjuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKyh1TLPR5qB2UzCyOUcp/ru5zp6oGiBGcUstXuby2U=;
 b=IC7VwPlysb07oeQ0g+YnDrDTIr6IoNYcA0znEq/HqTjI9LJZI1EjokOILvAGRnEdg7cBLawm7b3VapWA5TKzqDhnY3C4phsHp9wvZfRWnth9nB19em7CFayDqWTU5i7iZaxu2989UTQ5Fp6whDlnp7UjlGKsJiLWAVvxCue///cBMA48U3r4d3V+979etxtMNFHA2Bl19TwIwNraFt5rstRBB0zti3/wOLDPKs9cwTZRCqH02bz1wkryi7A10mR2fy1itWdJhjGbJGUJ14hqq0DGyv8cCaMobOPxdOQ+Z3vTMZ6+fe3SEoyvaAxqH/QdRD+h8BWarOPA3bZmXkPWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17)
 by AM6PR04MB6229.eurprd04.prod.outlook.com (2603:10a6:20b:73::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 25 Jun
 2020 13:31:56 +0000
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55]) by AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55%4]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 13:31:56 +0000
From: Lin Ma <LMa@suse.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 3/3] scsi-disk: Add support for the GET LBA STATUS 16
 command
Thread-Topic: [PATCH v2 3/3] scsi-disk: Add support for the GET LBA STATUS 16
 command
Thread-Index: AQHWSvQxz+RZHaXBskW3HtbW8IrNWw==
Date: Thu, 25 Jun 2020 13:31:56 +0000
Message-ID: <AM6PR04MB578290CA80CC6000756C4C0EC5920@AM6PR04MB5782.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
x-originating-ip: [124.192.225.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e262010-49cc-46f6-843d-08d8190c2150
x-ms-traffictypediagnostic: AM6PR04MB6229:
x-microsoft-antispam-prvs: <AM6PR04MB6229DA40472D036D29069D38C5920@AM6PR04MB6229.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6UMACDPvCBEnJOkgjnPcYcyyB8uf8WOb5ZINQSl43ayPCQLgHYWZKWiiA4WEQ+RsfenRmypj3flspgXMHC0a8yvYYiIr8uS/0xZkWzjACwpAdvnTq71WqdmbBTEhq1ADvgXyfNWmsaw8TVs4bBOE5+2Pc5uzl2L0BhovoIg36/0geOJ1iZU1LL3rH+jNYooLX++FmWKdT7ZOF4TZxvIZEvTPNQw+vWewhN6TnASPrjKh72QNfbzniQyQmawNKPRS90IU7sJGQ67ATMHog+Jwkjb7WfIBC2Ec+jay/XrFYm2avaaWultEj14IOvGc/gkL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5782.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(39860400002)(366004)(396003)(346002)(376002)(55236004)(2906002)(478600001)(316002)(4326008)(26005)(33656002)(186003)(52536014)(5660300002)(66446008)(64756008)(8676002)(66556008)(83380400001)(66476007)(71200400001)(55016002)(91956017)(6916009)(76116006)(54906003)(9686003)(66946007)(86362001)(7696005)(6506007)(53546011)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: b/zi/3bfwfZ6sDRzjabVIFO1K0xjsCSmZV4BUiA98l9OXTS1ULQmYkzZ/epevrDtgHfU2IfYFqwTy3/xmDm/9WkNrVBCtvHR0F8bweqM+YE+VDcPzMruMENpqKk4SlmqDw3mcYhddMpDeYj9CV6KHzlTrSxaAFe2qvHfmGVECkTWe/9Odk/86t6TFB+fUik0XHEf7ALiNNRmOQIKVtU5CAKdJEb8+pr2iP2rxcl3SsjiaI3t9KL4GoQ8OtxJxz2v1cWI6ZyFolfzeBgXVy6eevhNXpQNEWytfYmBsj+w2Npn/sUtKaWpy1eWNqrzo5lZAn14SmVaUnlWAnyMi/e+mdW+Acy5WpFSBjceZD+IcLEDub4+LmuYp5eN9p9mUggACedg/3KDwi0+3Ze4TVKy5MXM93RQNaSDUOzVffITEK+T5weGeSI4+UeYFXur51Ruz3Tt7hlyYHodnEsNH83NpMjLOyq5T9X8vYYJg187xVZYlL9eK3OlL+z+Roecf9bN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e262010-49cc-46f6-843d-08d8190c2150
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 13:31:56.1232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJ5hvOo+jCoIKk5XWaVoQG/2agM0nuskoR6p1RaeLYT68U7zR6wTgj8Hr9lLrh5l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6229
Received-SPF: pass client-ip=62.140.7.102; envelope-from=lma@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 09:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-06-25 21:25, Lin Ma wrote:=0A=
> From: Stefan Hajnoczi=0A=
> Sent: Monday, June 22, 2020 8:14 PM=0A=
> ...=0A=
>> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c=0A=
>> index 387503e11b..9e3002ddaf 100644=0A=
>> --- a/hw/scsi/scsi-disk.c=0A=
>> +++ b/hw/scsi/scsi-disk.c=0A=
>> @@ -1866,6 +1866,89 @@ static void scsi_disk_emulate_write_data(SCSIRequ=
est *req)=0A=
>>      }=0A=
>>  }=0A=
>>=0A=
>> +typedef struct GetLbaStatusCBData {=0A=
>> +    uint32_t num_blocks;=0A=
>> +    uint32_t is_deallocated;=0A=
>> +    SCSIDiskReq *r;=0A=
>> +} GetLbaStatusCBData;=0A=
>> +=0A=
>> +static void scsi_get_lba_status_complete(void *opaque, int ret);=0A=
>> +=0A=
>> +static void scsi_get_lba_status_complete_noio(GetLbaStatusCBData *data,=
 int ret)=0A=
>> +{=0A=
>> +    SCSIDiskReq *r =3D data->r;=0A=
>> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);=0A=
>> +=0A=
>> +    assert(r->req.aiocb =3D=3D NULL);=0A=
>> +=0A=
>> +    block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,=0A=
>> +                     s->qdev.blocksize, BLOCK_ACCT_GET_LBA_STATUS);=0A=
>> +=0A=
>> +    r->req.aiocb =3D blk_aio_get_lba_status(s->qdev.conf.blk,=0A=
>> +                                          r->req.cmd.lba * s->qdev.bloc=
ksize,=0A=
>> +                                          s->qdev.blocksize,=0A=
>> +                                          scsi_get_lba_status_complete,=
 data);=0A=
>> +}=0A=
>> +=0A=
>> +static void scsi_get_lba_status_complete(void *opaque, int ret)=0A=
>> +{=0A=
>> +    GetLbaStatusCBData *data =3D opaque;=0A=
>> +    SCSIDiskReq *r =3D data->r;=0A=
>> +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);=0A=
>> +=0A=
>> +    assert(r->req.aiocb !=3D NULL);=0A=
>> +    r->req.aiocb =3D NULL;=0A=
>> +=0A=
>> +    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));=0A=
>> +    if (scsi_disk_req_check_error(r, ret, true)) {=0A=
>> +        g_free(data);=0A=
>> +        goto done;=0A=
>> +    }=0A=
>> +=0A=
>> +    block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);=0A=
>> +    scsi_req_unref(&r->req);=0A=
>> +    g_free(data);=0A=
>> +=0A=
>> +done:=0A=
>> +    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));=0A=
>> +}=0A=
>> +=0A=
>> +static void scsi_disk_emulate_get_lba_status(SCSIRequest *req, uint8_t =
*outbuf)=0A=
>> +{=0A=
>> +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);=0A=
>> +    GetLbaStatusCBData *data;=0A=
>> +    uint32_t *num_blocks;=0A=
>> +    uint32_t *is_deallocated;=0A=
>> +=0A=
>> +    data =3D g_new0(GetLbaStatusCBData, 1);=0A=
>> +    data->r =3D r;=0A=
>> +    num_blocks =3D &(data->num_blocks);=0A=
>> +    is_deallocated =3D &(data->is_deallocated);=0A=
>> +=0A=
>> +    scsi_req_ref(&r->req);=0A=
>> +    scsi_get_lba_status_complete_noio(data, 0);=0A=
> =0A=
> scsi_get_lba_status_complete_noio() looks asynchronous. If the=0A=
> BlockDriver yields in .bdrv_co_block_status() then the operation has not=
=0A=
> completed yet when scsi_get_lba_status_complete_noio() returns. It is=0A=
> not safe to access the GetLbaStatusCBData data until the async operation=
=0A=
> is complete.=0A=
> =0A=
> Also, scsi_get_lba_status_complete() calls g_free(data) so there is a=0A=
> use-after-free when *num_blocks and *is_deallocated are accessed.=0A=
> =0A=
> These issues can be solved by making this code asynchronous (similar to=
=0A=
> read/write/flush/discard_zeroes/ioctl). outbuf[] will be filled in in=0A=
> the completion function before g_free(data) is called.=0A=
=0A=
Emm, I need to dig into the code for better understanding your suggestion.=
=0A=
I used to think that I already completely make 'scsi_get_lba_status_complet=
e_noio'=0A=
asynchronous.=0A=
=0A=
>> +=0A=
>> +    /*=0A=
>> +     * 8 + 16 is the length in bytes of response header and=0A=
>> +     * one LBA status descriptor=0A=
>> +     */=0A=
>> +    memset(outbuf, 0, 8 + 16);=0A=
>> +    outbuf[3] =3D 20;=0A=
>> +    outbuf[8] =3D (req->cmd.lba >> 56) & 0xff;=0A=
>> +    outbuf[9] =3D (req->cmd.lba >> 48) & 0xff;=0A=
>> +    outbuf[10] =3D (req->cmd.lba >> 40) & 0xff;=0A=
>> +    outbuf[11] =3D (req->cmd.lba >> 32) & 0xff;=0A=
>> +    outbuf[12] =3D (req->cmd.lba >> 24) & 0xff;=0A=
>> +    outbuf[13] =3D (req->cmd.lba >> 16) & 0xff;=0A=
>> +    outbuf[14] =3D (req->cmd.lba >> 8) & 0xff;=0A=
>> +    outbuf[15] =3D req->cmd.lba & 0xff;=0A=
>> +    outbuf[16] =3D (*num_blocks >> 24) & 0xff;=0A=
>> +    outbuf[17] =3D (*num_blocks >> 16) & 0xff;=0A=
>> +    outbuf[18] =3D (*num_blocks >> 8) & 0xff;=0A=
>> +    outbuf[19] =3D *num_blocks & 0xff;=0A=
>> +    outbuf[20] =3D *is_deallocated ? 1 : 0;=0A=
> =0A=
> SCSI defines 3 values and QEMU can represent all of them:=0A=
> =0A=
> 0 - mapped or unknown=0A=
> 1 - deallocated=0A=
> 2 - anchored=0A=
> =0A=
> See the BDRV_BLOCK_* constants in include/block/block.h. The=0A=
> is_deallocated boolean is not enough to represent this state, but the=0A=
> bdrv_block_status() return value can be used instead.=0A=
=0A=
I don't know which one in BDRV_BLOCK_* can be used to represent 'anchored'.=
=0A=
It seems that I need to use BDRV_BLOCK_* combination to recognized 'anchore=
d',=0A=
=0A=
I'd like to use these combinations to analyze the bdrv_block_status() retur=
n value:=0A=
'deallocated': BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_=
ZERO=0A=
'anchored':    BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID | ! BDRV_BLOC=
K_ZERO | ! BDRV_BLOCK_DATA=0A=
Am I right?=0A=
=0A=
=0A=
>> +}=0A=
>> +=0A=
>>  static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf=
)=0A=
>>  {=0A=
>>      SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);=0A=
>> @@ -2076,6 +2159,13 @@ static int32_t scsi_disk_emulate_command(SCSIRequ=
est *req, uint8_t *buf)=0A=
>>=0A=
>>              /* Protection, exponent and lowest lba field left blank. */=
=0A=
>>              break;=0A=
>> +        } else if ((req->cmd.buf[1] & 31) =3D=3D SAI_GET_LBA_STATUS) {=
=0A=
>> +            if (req->cmd.lba > s->qdev.max_lba) {=0A=
>> +                goto illegal_lba;=0A=
>> +            }=0A=
>> +            scsi_disk_emulate_get_lba_status(req, outbuf);=0A=
>> +            r->iov.iov_len =3D req->cmd.xfer;=0A=
>> +            return r->iov.iov_len;=0A=
> =0A=
> Is there something tricky going on here with iov_len that prevents us=0A=
> from using break here and sharing the functions normal return code path?=
=0A=
=0A=
Using 'break' here and following the normal return code path cause the asse=
rtion=0A=
'assert(!r->req.aiocb)'.=0A=
=0A=
In fact, There is a 'return' statement in the 'case SYNCHRONIZE_CACHE' in f=
unction=0A=
scsi_disk_emulate_command, It causes the same assertion if no this 'return'=
 statement.=0A=
I borrowed this idea to avoid the assertion.=0A=
=0A=
>>          }=0A=
>>          trace_scsi_disk_emulate_command_SAI_unsupported();=0A=
>>          goto illegal_request;=0A=
>> diff --git a/include/block/accounting.h b/include/block/accounting.h=0A=
>> index 878b4c3581..645014fb0b 100644=0A=
>> --- a/include/block/accounting.h=0A=
>> +++ b/include/block/accounting.h=0A=
>> @@ -38,6 +38,7 @@ enum BlockAcctType {=0A=
>>      BLOCK_ACCT_WRITE,=0A=
>>      BLOCK_ACCT_FLUSH,=0A=
>>      BLOCK_ACCT_UNMAP,=0A=
>> +    BLOCK_ACCT_GET_LBA_STATUS,=0A=
>>      BLOCK_MAX_IOTYPE,=0A=
>>  };=0A=
>>=0A=
>> diff --git a/include/scsi/constants.h b/include/scsi/constants.h=0A=
>> index 874176019e..b18377b214 100644=0A=
>> --- a/include/scsi/constants.h=0A=
>> +++ b/include/scsi/constants.h=0A=
>> @@ -154,6 +154,7 @@=0A=
>>   * SERVICE ACTION IN subcodes=0A=
>>   */=0A=
>>  #define SAI_READ_CAPACITY_16  0x10=0A=
>> +#define SAI_GET_LBA_STATUS    0x12=0A=
>>=0A=
>>  /*=0A=
>>   * READ POSITION service action codes=0A=
>> --=0A=
>> 2.26.0=0A=
>>=0A=


